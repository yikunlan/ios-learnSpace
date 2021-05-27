//
//  MainCV.swift
//  SwiftDemo
//
//  Created by  huangyikun on 2020/5/13.
//  Copyright © 2020  huangyikun. All rights reserved.
//

import UIKit

class MainCV: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let titleArray = ["ShopCenterMainVC","GroupListVc","GPUImageVC","TableViewVC","MiddleListVC",
                      "DBVC","TestVC","AnimationVC","UIDrawVc","TouchVC","GestureVC","ClockVC",
                      "AnimationLearnVC","DrawBoardVCBoard","CollisionVC"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tb = UITableView(frame: UIScreen.main.bounds)
        tb.delegate = self
        tb.dataSource = self
        
        view.addSubview(tb)
    }
    // MARK: - delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cellId = "cellId"
        
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if(cell == nil){
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        }
        cell?.textLabel?.text = titleArray[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let namespace = Bundle.main.infoDictionary!["CFBundleExecutable"]as! String
        let vcName = titleArray[indexPath.row]
        if (vcName.contains("Board")) {
            //使用storeBoard的形式
            
            //name为sb的名字(这边为了方便，统一为vc的名字)
            let sb = UIStoryboard.init(name: vcName, bundle: nil)
            //Identifier为在storeboard中设置的identifier的名字(这边为了方便，统一为vc的名字)
            let vc = sb.instantiateViewController(withIdentifier: vcName)
            navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = NSClassFromString(namespace + "." + vcName) as! UIViewController.Type
            navigationController?.pushViewController(vc.init(), animated: true)
        }
    }
    
}
