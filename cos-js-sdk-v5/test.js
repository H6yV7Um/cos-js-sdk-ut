const fs = require('fs');
const path = require('path');
const express = require('express');
const puppeteer = require('puppeteer');

var config = {

};

// 启动静态服务器
var app = express();
app.use('/', express.static(__dirname));
app.listen(4005);

var versionList = ['0.3.5', '0.3.7'];

// 打开测试页面
puppeteer.launch({
    args: [
        '--no-proxy-server',
    ]
}).then(function (browser) {
    var pageCount = versionList.length;
    versionList.forEach(function (version) {
        browser.newPage().then(function (page) {
            page.on('console', function (msg) {
                var text = msg.text();
                if (text === '[exit]') {
                    page.close();
                    if (--pageCount <= 0) {
                        browser.close();
                        process.exit();
                    }
                } else if (text.indexOf('[report]') === 0) {
                    var report = text.substr('[report]'.length);
                    console.log(report);
                    fs.writeFileSync(path.resolve(__dirname, `./output/js5-v${version}.xml`), report);
                } else {
                    console.log(text);
                }
            });
            page.goto(`http://127.0.0.1:4005/${version}/index.html`);
        });
    });
});