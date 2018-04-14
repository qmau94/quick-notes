# Share video unlimited với Google back up and sync

Việc Mỹ tấn công Syria làm giá dầu thô và bitcoin tăng cao, một số anh em có thể ăn đậm trong đợt vừa rồi. Trong một diễn biến khác, qmau.me cũng đã có thêm một feature mới, đó là dịch vụ chia sẻ video (hiện tại mới chỉ có mình chia sẻ được cho các bạn thôi). Loạt video đầu tiên là về react-redux, phục vụ trực tiếp cho quá trình học của mình =))

Mình xin chia sẻ cách share host video unlimited qua service Back up and Sync của Google và Google sdk cho nodejs.

## Đăng ký tài khoản google
- Để sử dụng dịch vụ, các bạn cần có []đăng ký một tài khoản google](https://accounts.google.com/SignUp?hl=vi) (chắc chắn rồi)
- Sau đó [download google back up and sync](https://www.google.com/drive/download/backup-and-sync/)

## Google drive API
- Các bạn có thể đọc bản [hướng dẫn cụ thể tại document của google](https://developers.google.com/drive/v3/web/quickstart/nodejs)
- Hoặc bản tiếng Việt tại đây:
  - Cài đặt [nodejs&npm](https://docs.npmjs.com/getting-started/installing-node#1-install-nodejs--npm)
  - Enable Google Drive API bằng cách [tạo một project mới](https://console.developers.google.com/flows/enableapi?apiid=drive)
  - Config một số thông tin cho ứng dụng
  - Tạo credential để truy cập data từ google drive (OAuth Client ID nhé)
  - Download file credential client_secret*.json về và sử dụng.

## Nodejs
- Cài đặt library cho google apis.
```bash
npm install googleapis@27 --save
```
- Lúc đầu mình sử dụng file theo template của google, tuy nhiên không lấy được một số thông tin (link của video chẳng hạn), đọc thêm về [scope của API](https://developers.google.com/drive/v3/web/about-auth) mình mới phát hiện họ dùng scope readonly cho file mẫu. Nếu muốn lấy đầy đủ thông tin mình cần sử dụng scope full permission `https://www.googleapis.com/auth/drive`
Và như vậy thì file mẫu sẽ được sửa thành như sau:

`quickstart.js`

```javascript
const fs = require('fs');
const readline = require('readline');
const google = require('googleapis');
const OAuth2Client = google.auth.OAuth2;
// Chỗ này bị lừa này =))
const SCOPES = ['https://www.googleapis.com/auth/drive'];
const TOKEN_PATH = './credentials.json';

fs.readFile('./client_secret.json', (err, content) => {
  if (err) return console.log('Error loading client secret file:', err);
  authorize(JSON.parse(content), listFiles);
});

function authorize(credentials, callback) {
  const {client_secret, client_id, redirect_uris} = credentials.installed;
  const oAuth2Client = new OAuth2Client(client_id, client_secret, redirect_uris[0]);

  fs.readFile(TOKEN_PATH, (err, token) => {
    if (err) return getAccessToken(oAuth2Client, callback);
    oAuth2Client.setCredentials(JSON.parse(token));
    callback(oAuth2Client);
  });
}

function getAccessToken(oAuth2Client, callback) {
  const authUrl = oAuth2Client.generateAuthUrl({
    access_type: 'offline',
    scope: SCOPES,
  });
  console.log('Authorize this app by visiting this url:', authUrl);
  const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout,
  });
  rl.question('Enter the code from that page here: ', (code) => {
    rl.close();
    oAuth2Client.getToken(code, (err, token) => {
      if (err) return callback(err);
      oAuth2Client.setCredentials(token);
      fs.writeFile(TOKEN_PATH, JSON.stringify(token), (err) => {
        if (err) console.error(err);
        console.log('Token stored to', TOKEN_PATH);
      });
      callback(oAuth2Client);
    });
  });
}

function listFiles(auth) {
  const drive = google.drive({version: 'v3', auth});
  drive.files.list({
    pageSize: 10,
    fields: 'nextPageToken, files(id, name)',
  }, (err, {data}) => {
    if (err) return console.log('The API returned an error: ' + err);
    const files = data.files;
    if (files.length) {
      console.log('Files:');
      files.map((file) => {
        console.log(`${file.name} (${file.id})`);
      });
    } else {
      console.log('No files found.');
    }
  });
}
```
