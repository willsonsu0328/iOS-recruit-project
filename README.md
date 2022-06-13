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
* PureLayout ：方便使用 constraints
* SDWebImage ：讀取圖片

### 介紹

* CourseHomeViewModel
  * Setting
    * 取得目前裝置
  * Presentation
    * 處理 cell 顯示邏輯  
  * Storage
    * 課程資料來源
    * 儲存課程資料
  * Signals
    * 處理資料流
    * data binding
* DataServiceProtocol
  * 抽象資料來源，方便之後擴充，例：資料來源為 API
* JSONDataHelper
  * 負責處理本地 json 相關檔案
* CourseDataLoader
  * 負責處理課程資料，有其他課程相關資料，可以在此一併處理
* ErrorHelper
  * 定義資料錯誤及描述
* Style
  * 定義整體 App 的顏色、字體、間距等

### 介面設計

* 使用 CollectionView、Compositional Layout
* 考量到 iPad 分割畫面，分兩種 CollectionViewLayout 處理

### 畫面呈現

* iPhone

 ![iPhone 12](https://user-images.githubusercontent.com/12155964/173267891-8bbbf0ea-50e3-4481-b700-bf87f771d6f5.gif)
 
* iPad 直向

![iPad Pro (9 7-inch) - portrait](https://user-images.githubusercontent.com/12155964/173268283-8315b9e8-07ac-412a-8b6c-bcf530107be8.gif)

* iPad 橫向

![iPad Pro (9 7-inch) - landscape](https://user-images.githubusercontent.com/12155964/173267869-a733a102-cec1-4845-bf4c-2839a45e2515.gif)

* iPad 直向分割畫面

![iPad Pro (9 7-inch) - portrait_multitasking](https://user-images.githubusercontent.com/12155964/173267944-3763d58a-49dc-46ac-a410-596090f0647d.gif)

* iPad 橫向分割畫面

![ iPad Pro (9 7-inch) - landscape_multitasking ](https://user-images.githubusercontent.com/12155964/173267958-74757d7d-c507-4b5c-812e-af86b99f631f.gif)





