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

#### iPhone

![iPhone 12](https://user-images.githubusercontent.com/12155964/173270970-0190bda1-867d-4beb-b61b-230ffeaebc2a.gif)
 
#### iPad 直向

![iPad Pro (9 7-inch) - portrait](https://user-images.githubusercontent.com/12155964/173270993-a0671c48-a430-4fca-9836-c2790dcfa5c5.gif)

#### iPad 橫向

![iPad Pro (9 7-inch) - landscape](https://user-images.githubusercontent.com/12155964/173271021-3bd42444-92c0-442a-b021-5b7539c568fa.gif)

#### iPad 直向分割畫面

![iPad Pro (9 7-inch) - portrait_multitasking](https://user-images.githubusercontent.com/12155964/173271048-0cb6dc0c-4407-4df3-a406-73660c1e7b32.gif)

#### iPad 橫向分割畫面

![ iPad Pro (9 7-inch) - landscape_multitasking ](https://user-images.githubusercontent.com/12155964/173271079-d0d897dd-e161-4fe6-947f-73ca2b565ba9.gif)

