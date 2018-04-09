# aws lambda - java vnnlp

Từ hồi đi làm, thời gian ~~làm việc và học tập~~ chơi bời đã làm giảm bớt thời gian ngủ của mình khá nhiều, kết quả là dù đã qua rằm tháng Giêng khá lâu mà mình vẫn chưa làm được gì để lại cho hậu thế 😅. Vào một ngày đẹp trời bookmark dạo trên medium mình có đọc được bài ["I just deployed a serverless app — and I can’t code. Here’s how I did it.
"](https://medium.freecodecamp.org/i-just-deployed-a-serverless-app-and-i-cant-code-here-s-how-i-did-it-94983d7b43bd) của [Andrea Passwater](https://medium.freecodecamp.org/@andrea.passwater). Một trong vài mục tiêu của mình trong năm nay là tìm hiểu về AWS và bài viết trên đã giúp mình có thêm chút xấu hổ để "no more excuses and get my hands dirty" với AWS lambda và serverless 😂

<script type="text/javascript" src="https://ssl.gstatic.com/trends_nrtr/1328_RC04/embed_loader.js"></script> <script type="text/javascript"> trends.embed.renderExploreWidget("TIMESERIES", {"comparisonItem":[{"keyword":"serverless","geo":"","time":"today 5-y"},{"keyword":"aws lambda","geo":"","time":"today 5-y"}],"category":0,"property":""}, {"exploreQuery":"date=today%205-y&q=serverless,aws%20lambda","guestPath":"https://trends.google.com:443/trends/embed/"}); </script>

## Serverless là gì?
Bạn:
- Chưa có kinh nghiệm làm việc với CLI, terminal.
- Chưa có kinh nghiệm về infra.
- Không muốn mất thời gian config cấu hình cho server.
- Muốn giảm thiểu chi phí host service của mình.

Serverless sinh ra là để dành cho các bạn. Với kiến trúc không-server, bạn chỉ cần viết source code, cả thế giới để serverless service lo 😌

Serverless services (FaaS - Fucntion as a Service) được cung cấp bởi nhiều hệ thống cloud nên bạn có thể thoải mái lựa chọn:
- **AWS Lambda** ← [my choice](https://en.wikipedia.org/wiki/AWS_Lambda)
- Google cloud functions
- Azure functions

_ps: mình sẽ viết rõ hơn trong bài viết tổng kết về AWS Lambda_

## Phân tích:
### Yêu cầu:
Một micro service thực hiện việc phân tích ngôn ngữ tiếng Việt (tokenizer, pos tagging, ner,...)
### Công nghệ sử dụng:
- Serverless: AWS lambda
  - awscli (mình thì dùng luôn web cho nhanh 😅)
  - docker
  - SAM local
- NPL: Sau khi tham khảo các [NPL-toolkit](https://github.com/magizbox/underthesea/wiki/Vietnamese-NLP-Tools) và đọc document của lambda thấy có hỗ trợ java → chọn [VnCoreNLP](https://github.com/vncorenlp/VnCoreNLP) vì document rõ ràng và performance khá ổn.

## Get my hands dirty
### Chuẩn bị tài khoản aws free-tier
[Đăng ký một tài khoản free-tier của AWS](https://aws.amazon.com/free/) +
với một thẻ visa, một số điện thoại các bạn có thể sử dụng **miễn phí** nhiều services trong 1 năm, và thậm chí với AWS lambda bạn thậm chí còn được sử dụng không thời hạn:
- 1,000,000 requests miễn phí/tháng.
- 3.2 triệu giây tính toán miễn phí/tháng.

### Cài đặt môi trường
_[Hướng dẫn dành cho deverloper của AWS](https://docs.aws.amazon.com/lambda/latest/dg/welcome.html)_
#### 1. cấu hình aws
Đăng ký một user profile bằng IAM(Identity and Access Management) và cấu hình với awscli theo hướng dẫn tại [document của AWS](https://docs.aws.amazon.com/lambda/latest/dg/setup-awscli.html).
#### 2. cài đặt SAM local (optional)
SAM dùng để test serverless function trên môi trường local trước khi deploy lên aws lambda
- Cài đặt docker: Hướng dẫn cài đặt và đọc document [đây](https://www.docker.com/)
- Cài đặt SAM bằng npm:
```bash
npm install -g aws-sam-local
sam --version
```

### Java project
- Sau khi chuẩn bị xong môi trường của AWS lambda chúng ta cần bắt đầu việc phát triển code cho service, để deploy mình sẽ chọn tạo Java project với maven và Eclipse vì mọi chuyện sẽ đơn giản hơn nếu có [document hướng dẫn đầy đủ](https://docs.aws.amazon.com/lambda/latest/dg/java-create-jar-pkg-maven-and-eclipse.html)
- Import thư viện [VnCoreNLP](https://github.com/vncorenlp/VnCoreNLP) vào maven project vừa tạo ([hướng dẫn cụ thể tại đây](http://www.mkyong.com/maven/how-to-include-library-manully-into-maven-local-repository/)).

Đến đây là đã đi được nửa quãng đường rồi 😂

### Code
Tuy không phải code phần xử lý ngôn ngữ (vì đã có sẵn) nhưng vẫn cần tìm hiểu một chút về lambda-java-core để có thể viết được phần nhận, xử lý và trả giữ liệu cho service. Rất may rằng AWS có hệ thống document _quá đầy đủ_, đọc qua một chút về [Programming Model for Authoring Lambda Functions in Java](https://docs.aws.amazon.com/lambda/latest/dg/java-programming-model.html)

> The blueprints provide sample code authored either in Python or Node.js. You can easily modify the example using the inline editor in the console. However, if you want to author code for your Lambda function in Java, there are no blueprints provided. Also, there is no inline editor for you to write Java code in the AWS Lambda console.

> That means, you must write your Java code and also create your deployment package outside the console. After you create the deployment package, you can use the console to upload the package to AWS Lambda to create your Lambda function. You can also use the console to test the function by manually invoking it.

→ Các bạn có thể chọn nodejs hoặc python để có thể test trực tiếp bằng lambda console, còn mình ngại viết lại đoạn blog trên nên đành theo lao vậy 😅 Không sao, có thể test bằng SAM local sử dụng docker.

![setup-1](https://qmau.me/uploads/Hq7VgdE7ZvpL4b53.jpg)
Sau import package VnCoreNLP vào project, code xong xuôi và chạy test ổn định trên sam-local cho kết quả đúng và thêm các models hỗ trợ → build package sẽ có size ~ 130MB, AWS Lambda [giới hạn deployment package <50Mb](https://docs.aws.amazon.com/lambda/latest/dg/limits.html) nên không thể sử dụng toolkit này cho function của mình.😓

Vì thế nên mình chuyển qua sử dụng [RDRsegmenter](https://github.com/datquocnguyen/RDRsegmenter) cũng là 1 project của tác giả VnCoreNLP, chỉ có thể dừng lại ở việc tokenizer.

Lúc đó thì mọi chuyện sẽ đơn giản hơn nhiều.
- Viết hàm handler

`/java/src/main/qmau/me/vnnlp/handler/VnNlpHandler.java`
```java
package qmau.me.vnnlp.handler;

import org.json.simple.JSONObject;

import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.RequestHandler;

import vnnlp.core.RDRsegmenter;

public class VnNlpHandler implements RequestHandler<JSONObject, String> {

    public String handleRequest(JSONObject input, Context context) {
        context.getLogger().log("Input: " + input + "\n");
        String text = (String) input.get("text");
        String result = new String();
        try {
            RDRsegmenter segmenter = new RDRsegmenter();
            result = segmenter.segmentRawString(text);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }

}
```

- Chuẩn bị các file cho việc test bằng sam-local

`/template.yml`

```xml
AWSTemplateFormatVersion: 2010-09-09
Transform: AWS::Serverless-2016-10-31

Resources:
  ExampleJavaFunction:
    Type: AWS::Serverless::Function
    Properties:
      Handler: qmau.me.vnnlp.handler.VnNlpHandler
      CodeUri: ./target/vnnlp-1.0.0.jar
      Runtime: java8
```

- input test file có dạng json

`/test.json`
```json
{
  "text": "Đứng đầu về thị phần nhưng CGV gặp không ít rắc rối. Hồi giữa năm 2016, CGV từng bị 8 nhà sản xuất và phát hành phim Việt Nam tố cáo ăn chia phòng vé không sòng phẳng. Theo khiếu nại của 8 đơn vị, CGV đã áp đặt tỷ lệ ăn chia bất hợp lý tại hệ thống rạp của mình, khi phim do CGV phát hành hay phim do các đối tác khác phát hành thì CGV cũng hưởng 55%, trong khi các hãng nhận 45%. Do số lượng rạp của CGV quá lớn (thời điểm đó chiếm 40% tổng số rạp phim trong cả nước) nên các doanh nghiệp điện ảnh trong nước không còn cách nào khác là phải chịu sự áp đặt của CGV. Nếu không đồng ý tỷ lệ này thì phim của họ sẽ không được chiếu trên 40% số rạp.Đơn khiếu nại lúc bấy giờ khẳng định, đây là điều chưa từng xảy ra trên thế giới khi hệ thống rạp chiếu phim lại nhận được lớn hơn nhà sản xuất và phát hành - những người bỏ chi phí lớn, không chỉ cho sản xuất phim, mà còn cho marketing và phát hành phim."
}
```

- Test bằng SAM-local và docker
```bash
sam local invoke -e test.json
```
Kết quả nhận được như sau:

![sam-local-test](https://qmau.me/uploads/Khmhx3kY1A0dseW8.jpg)

- Upload lên aws thông qua web-ui và setup Gateway API tạo endpoint cho function.

![gate-way-setup](https://qmau.me/uploads/J8TUBWBqOcsikJ6-.jpg)

- Tạo invoke cho lambda function bằng method POST với payload JSON

![api-function](https://qmau.me/uploads/J8TUBWBqOcsikJ6-.jpg)

- Test thử call service theo endpoint của AWS.

![aws-function-test](https://qmau.me/uploads/IC7eWh4WJDbZhIaU.jpg)

- Đọc log trên AWS CloudWatch

![aws-cloudwatch-log](https://qmau.me/uploads/HCNtXitcvoOvabPD.jpg)

## Đánh giá

### Đáp ứng yêu cầu
- Đạt được 1/5 yêu cầu ban đầu → **2 điểm** về chỗ.

### Lãng phí?
Có, nếu mất thời gian để học mà vẫn làm được một cái gì đó có thể dùng luôn thì cuộc đời sẽ đẹp biết bao 🤩 Chỉ tham khảo documant của AWS và tự mày mò sẽ khiến mình mất nhiều thời gian. However, chắc chắn đây không phải lần cuối cùng mình làm việc với aws-lambda → lãng phí chấp nhận được.

### Learned lessons?
- Document của AWS rất chi tiết và đầy đủ, đầy đủ  đến mức nhiều khi mình không thể đọc hết → đọc document cũng như đọc sách, cần đọc mục lục trước 😅
- Nên hiểu rõ use cases của từng services, ngay từ đầu mục tiêu của mình và [uses case của AWS Lambda](https://docs.aws.amazon.com/lambda/latest/dg/use-cases.html) đã không giống nhau → chúng ta không thuộc về nhau 😞
- Đôi khi việc lạm dụng IDE sẽ làm mọi thứ phức tạp hơn, việc tự config, compile và làm việc trên CLI với nhiều project khác nhau sẽ giúp tự mình có một cái nhìn trong suốt hơn về chúng.
- Làm việc với maven và maven projects.
- Java Json parser.
- AWS Cloud watch, lambda.
- Nên tìm hiểu về AWS RDB, DynamoDb, Kinesis,... trước để có thể tối ưu công năng của AWS Lambda.
- Với công nghệ, muốn học gì thì nên làm một cái gì đó sử dụng nó, đừng cưỡi ngựa xem hoa nhưng cũng đừng làm mà thiếu tìm hiểu (như mình 😅)

→ Nếu đây là một dự án và mình là leader thì chắc chắn sẽ fail, công nghệ sử dụng không đáp ứng được yêu cầu. Với những dự án được khách hàng tin tưởng giao cho việc tuỳ chọn công cụ sử dụng, việc biết thật nhiều công nghệ sẽ giúp ích các PL có một cái nhìn tốt hơn, lựa chọn được thứ tốt nhất và giảm thiểu chi phí cho khách. Dù sao thì mình cũng bắt đầu hình dung được AWS Lambda sẽ giúp giảm cost của một số service như thế nào. Chắc chắn mình sẽ có một bài viết gọn gàng và đầy đủ tút tát lại kiến thức và services sử dụng. Hi vọng sẽ sớm gặp lại các bạn 😂

Source code có tại: https://github.com/qmau94/aws-lambda-vnnlp

### refs:
- [AWS Lambda](https://docs.aws.amazon.com/lambda)
- [RDRsegmenter](https://github.com/datquocnguyen/RDRsegmenter)
- [VnCoreNLP](https://github.com/vncorenlp/VnCoreNLP)
- [Import maven external jars](http://www.mkyong.com/maven/how-to-include-library-manully-into-maven-local-repository/)
- [NPL-toolkit](https://github.com/magizbox/underthesea/wiki/Vietnamese-NLP-Tools)
- [Java JSON parser](https://www.mkyong.com/java/json-simple-example-read-and-write-json/)
- [Codestar](https://aws.amazon.com/codestar/)
- [SAM local](https://github.com/awslabs/aws-sam-local#installation)
- [Debug with SAM-local](https://aws.amazon.com/blogs/developer/aws-toolkit-for-eclipse-locally-debug-your-lambda-functions-and-api-gateway/)
