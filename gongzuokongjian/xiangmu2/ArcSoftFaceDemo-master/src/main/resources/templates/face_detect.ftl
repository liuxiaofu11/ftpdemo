<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/html">
<head>
    <title>人脸检测</title>
    <#import "common/common.macro.ftl" as netCommon>
    <@netCommon.commonStyle />
</head>

</head>
<body class="hold-transition sidebar-mini layout-fixed">
<div class="wrapper">
    <!-- Main Sidebar Container -->
    <@netCommon.commonSidebar "人脸检测" />
    <div class="content-wrapper">
        <h4 align="center" style="margin-top: 30px">
            人脸检测示例
        </h4>

        <div class="imageDiv">
            <#--            <canvas id="canvas" height="438" width="780"></canvas>-->
            <img id="img" height="438" width="auto" style="background-color: #7abaff"/>
        </div>


        <div>

            <span class="selectDiv" style="margin-left: 200px">选择图片：</span>
            <div class="dropdown selectDiv">
                <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton"
                        data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    Image1-1.jpg
                </button>
                <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                    <a class="dropdown-item" data-offset="ddd" href="#">Image1-1.jpg</a>
                    <a class="dropdown-item" href="#">Image2-1.jpg</a>
                    <a class="dropdown-item" href="#">Image3-1.jpg</a>
                </div>
            </div>

            <div class="selectDiv" style="margin-left: 20px">
                <#--                <input  type="file"  class="btn btn-outline-primary" name="aaa" value="bbb" />-->
                <input class="fileInput" type="file" accept="image/png, image/jpeg" value="" onchange="fileInput()">
            </div>


        </div>

    </div>

</div>

<@netCommon.commonScript />

<script>


    let img = document.getElementById('img');

    let firstImg = new Image();
    firstImg.src = 'images/Image1-1.jpg'

    firstImg.onload = function () {
        detectFace(this)
    }


    $(".dropdown").on('hidden.bs.dropdown', function (e) {
        let content = e.clickEvent.target.textContent;
        if (content.substring(0, 5) == 'Image') {
            e.relatedTarget.textContent = content;
            let img2 = new Image();
            img2.src = 'images/' + content
            img2.onload = function () {
                detectFace(img2)
            }
        }
    });

    function detectFace(image) {
        console.info("detectFace")
        let canvas = document.createElement('canvas');
        canvas.width = image.width;
        canvas.height = image.height;
        let ctx = canvas.getContext("2d");
        ctx.drawImage(image, 0, 0, image.width, image.height)

        $.post("/detectFaces", {image: canvas.toDataURL("image/png")}, function (result) {
            console.info(result)
            if (result.code === 0 && result.data.length > 0) {
                result.data.forEach(r => {
                    let rect = r.rect;
                    let x = rect.left;
                    let y = rect.top;
                    let w = rect.right - rect.left;
                    let h = rect.bottom - rect.top;
                    ctx.strokeStyle = "#FF0000";
                    ctx.lineWidth = 5;
                    ctx.strokeRect(x, y, w, h);
                    let gender = '未知'
                    if (r.gender === 0) {
                        gender = '男'
                    } else if (r.gender === 1) {
                        gender = '女'
                    }

                    let liveness = '-';
                    if (r.liveness == 1) {
                        liveness = '活体'
                    } else if (r.liveness == 0) {
                        liveness = '非活体'
                    }

                    let txt = '性别:' + gender + '，年龄:' + r.age + '，' + liveness;
                    ctx.fillStyle = "#FF0000";
                    ctx.font = "20px Georgia";
                    ctx.fillText(txt, x, y - 10);
                    console.info("detectSuccess")

                });
            }
            img.src = canvas.toDataURL("image/png");
        });
    }

    function fileInput() {
        let file = $(".fileInput")[0].files[0];
        let reader = new FileReader();
        reader.readAsDataURL(file);
        reader.onload = function () {
            let image = new Image();
            image.src = reader.result;
            image.onload = function () {
                detectFace(image);
            }
        }
        console.info("bbb")
    }


</script>

<style>

    .content-wrapper {
        width: 800px;
        background-color: #ffffff;
    }

    .selectDiv {
        display: inline;
    }

    .imageDiv {
        width: 800px;
        height: 440px;
        margin-left: 20px;
        margin-top: 20px;
        margin-bottom: 20px;
        /*background-color: #1aa67d;*/
        display: flex;
        align-items: center;
        justify-content: center;
        /*为了效果明显，可以将如下边框打开，看一下效果*/
        border: 1px solid black;
    }

</style>

</body>
</html>
