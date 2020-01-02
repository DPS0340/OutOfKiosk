//
//  StoreListController.swift
//  OutOfKiosk
//
//  Created by a1111 on 2020/01/02.
//  Copyright © 2020 OOK. All rights reserved.
//

import UIKit

/* TableView 구현 위해선 Delegate(, DataSource 두 프로토콜 상속 필요 */
class StoreListController : UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var CafeTableView: UITableView!
    
    var storeName = ["카페그리닝", "이디야커피", "스타벅스"]
    
    
   
    /* Cell 반복 횟수 관리 */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return storeName.count
        
    }
    
    /* Cell 편집 */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        /* 재사용할 수 있는 cell을 CafeTableView에 넣는다는 뜻. UITableViewCell을 반환하기 때문에 Storelist로 다운캐스팅 */
        let cell = CafeTableView.dequeueReusableCell(withIdentifier: "StoreList", for: indexPath ) as! StoreList
        
        /* StoreList 클래스(Cell Class)에 등록한 프로퍼티 이용 가능 */
        cell.storeName_Label.text = storeName[indexPath.row]
        
        return cell
    }
    
    /* 특정 Cell 클릭 이벤트 처리 */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        /* Switch로특정 row 접근 가능
        switch indexPath.row {
        case 0:
            vc.receivedValueFromBeforeVC = indexPath.row //해당 뷰와 관련된 .swift 파일의 변수에 값 전달
        case 1:
            vc.receivedValueFromBeforeVC = indexPath.row //해당 뷰와 관련된 .swift 파일의 변수에 값 전달
        case 2:
            vc
        default:
            print("nothing")
        } */
        
        /* view controller 간 데이터 교환
        : instantiateViewController를 통해 생성된 객체는 UIViewController타입이기 때문에 StoreDetailController 타입으로 다운캐스팅. */
        let vc = self.storyboard?.instantiateViewController(identifier: "StoreDetailController") as! StoreDetailController
        vc.receivedValueFromBeforeVC = indexPath.row
        //print(indexPath.row)
        
        /* StoreDetailController 로 화면 전환 */
        //self.present(vc, animated: true, completion: nil) // present 방식
        self.navigationController?.pushViewController(vc, animated: true) // navigation controller 방식
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* TableView의 대리자(delegate)는 self(StoreListController)가 됨 */
        CafeTableView.delegate = self
        CafeTableView.dataSource = self
        self.CafeTableView.rowHeight = 93.0
        
       
    }
    
    
    
}
