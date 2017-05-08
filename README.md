# webViewPopBut/longpress webview
这是一个附加在UIView上的长按手势动画 动画分为三部分 
#### 1长按view识别 
#### 2黑框围绕（若是webview则区分网页内容是超链接文本或图片） 
#### 3长按view下沉动画 
#### 4选择按钮动画弹出 
#### 5最后回调
###longpress Function in WebView/iOS 
###网页长按超链接 图片进行拷贝分享保存等
包含了：js简单解析交互，自动布局，pop动画，图片下载，图片保存，长按旋转弹出菜单等
使用了VLDContextSheet，Masonry.h等三方，cocoapod导入POP.h

Long Press in WebView to save ,copy ,share the link you pressed or
image you pressed.(using VLDContextSheet，Masonry.h,POP/facebook)

![](https://raw.githubusercontent.com/fonglaaaam/webViewPopBut/master/webViewBtn.gif)
