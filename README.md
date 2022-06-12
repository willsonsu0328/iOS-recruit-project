# iOS-recruit-project
Hahow iOS Engineer 面試小專案

### 環境

* 語言：Swift
* Xcode 版本： 13.2.1
* Deployment： 13.0
* Ruby 版本： 2.7.2
* Bundler 版本： 2.2.16
* CocoaPods 版本：1.11

### 第三方 library

* SwiftLint : coding style
* ReactiveCocoa : 實作 data binding
* PureLayout ：方便使用 contraints
* SDWebImage ：讀取圖片

### 介紹

* DataServiceProtocol：抽象資料來源，方便之後擴充，例：資料來源為 API
* JSONDataHelper：負責處理本地 json 相關檔案
* CourseDataLoader：負責處理課程資料，有其他課程相關資料，可以在此一併處理
* ErrorHelper：定義資料錯誤及描述
* Style：定義整體 App 的顏色、字體、間距等
