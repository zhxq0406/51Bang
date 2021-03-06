//
//  ShopViewController.swift
//  51Bang_ios_2016
//
//  Created by apple on 16/6/18.
//  Copyright © 2016年 校酷网络科技公司. All rights reserved.
//

import UIKit
import MBProgressHUD

class ShopViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITabBarControllerDelegate,ViewControllerDelegate {

    @IBOutlet weak var myTableView: UITableView!
    var showLogin = false
    let shopHelper = ShopHelper()
    var dataSource : Array<GoodsInfo>?
    let leftTableView = UITableView()
    let rightTableView = UITableView()
    var isShow = Bool()
    let coverView = UIView()
    let leftArr = ["全部分类","餐饮美食","休闲娱乐","个护化妆","按摩","养生","健身"]
    var rightArr = ["全部","足疗按摩","运动健身","KTV","其他养生保健","游乐园","其他游乐活动"]
    var rightArr0 = ["全部","足疗按摩","运动健身","KTV","其他养生保健","游乐园","其他游乐活动"]
    let rightArr1 = ["油压按摩","足底按摩","泰式按摩","养生","保健","治疗","美容"]
    let rightArr2 = ["八仙粉","辣子鸡","糖霜花生","武汉热干面","串串香","菌子汤","豌豆黄"]
    let rightArr3 = ["体育类","旅游类","游戏类","喝茶","聊天","上网","健身"]
    let rightArr4 = ["影视化妆","平面化妆","现代人物","经典化妆","普通化妆","化妆学习","化妆招聘"]
    let rightArr5 = ["饮食养生","调息养生","运动养生","保健养生","道家养生","大众养生","中医养生"]
    let rightArr6 = ["全部","足疗按摩","运动健身","KTV","其他养生保健","游乐园","其他游乐活动"]
    var rightKind:Array<[String]>?
    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.tabBar.hidden = false
        self.navigationController?.navigationBar.hidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rightKind = [rightArr0,rightArr2,rightArr,rightArr4,rightArr1,rightArr5,rightArr6]
        self.GetData()
        isShow = false

        // Do any additional setup after loading the view.
    }
    
    func GetData(){
        
        let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        hud.animationType = .Zoom
        hud.labelText = "正在努力加载"
        shopHelper.getGoodsList({[unowned self] (success, response) in
            dispatch_async(dispatch_get_main_queue(), {
                if !success {
                    return
                }
                hud.hide(true)
                print(response)
                self.dataSource = response as? Array<GoodsInfo> ?? []
                print(self.dataSource)
                print(self.dataSource?.count)
                self.createTableView()
                //                self.ClistdataSource = response as? ClistList ?? []
                self.myTableView.reloadData()
                //self.configureUI()
            })
        })
    
    }
    
    func createTableView(){
        
        myTableView.delegate = self
        myTableView.dataSource = self
        myTableView.registerNib(UINib(nibName: "ShopTableViewCell",bundle: nil), forCellReuseIdentifier: "cell")
        myTableView.rowHeight = WIDTH*80/375
        myTableView.tag = 0
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if tableView.tag == 0 {
            return 80
        }else if tableView.tag == 1{
        
            return CGFloat(tableView.frame.size.height/CGFloat(leftArr.count))
        }else{
        
            return CGFloat(tableView.frame.size.height/CGFloat(rightArr.count))
        }
        
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 0 {
            return (self.dataSource?.count)!
        }else if tableView.tag == 1{
        
            return self.leftArr.count
        }else{
        
            return self.rightArr.count
        }
        
        
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if tableView.tag == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)as!ShopTableViewCell
            
            cell.selectionStyle = .None
            let goodsInfo = self.dataSource![indexPath.row]
            cell.setValueWithModel(goodsInfo)
            return cell
        }else if tableView.tag == 1{
            tableView.separatorStyle = .None
            let cell = tableView.dequeueReusableCellWithIdentifier("leftTableView")
            cell?.textLabel?.text = leftArr[indexPath.row]
            return cell!
        }else{
            tableView.separatorStyle = .None
            let cell = tableView.dequeueReusableCellWithIdentifier("rightTableView")
            cell?.textLabel?.text = rightArr[indexPath.row]
            cell?.backgroundColor = UIColor.grayColor()
            return cell!
        }
      
        
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        print(indexPath.row)
        if tableView.tag == 0 {
            let next = BusnissViewController()
            next.goodsInfo = self.dataSource![indexPath.row]
            self.navigationController?.pushViewController(next, animated: true)
            next.title = "风景自助"
        }else if tableView.tag == 1{
            //刷新右侧tableView
            switch indexPath.row {
            case 0:
                rightArr = rightKind![0]
                rightTableView.reloadData()
            case 1:
                rightArr = rightKind![1]
                rightTableView.reloadData()
            case 2:
                rightArr = rightKind![2]
                rightTableView.reloadData()
            case 3:
                rightArr = rightKind![3]
                rightTableView.reloadData()
            case 4:
                rightArr = rightKind![4]
                rightTableView.reloadData()
            case 5:
                rightArr = rightKind![5]
                rightTableView.reloadData()
            default:
                rightArr = rightKind![6]
                rightTableView.reloadData()
            }
            print("点击cell")
        }else if(tableView.tag == 2 ){
            
            print("点击了右侧cell")
        }
        
        
    }
    
    @IBAction func goToMenu(sender: AnyObject) {
        print("菜单")
        
        
        if isShow == false {
            coverView.frame = CGRectMake(0, 0, WIDTH, HEIGHT-48)
            coverView.backgroundColor = UIColor.grayColor()
            coverView.alpha = 0.8
            leftTableView.frame = CGRectMake(0, 0, WIDTH/2, HEIGHT/2)
            leftTableView.tag = 1
            leftTableView.delegate = self
            leftTableView.dataSource = self
            leftTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "leftTableView")
            //        view.addSubview(leftTableView)
            leftTableView.backgroundColor = UIColor.whiteColor()
            rightTableView.frame = CGRectMake(WIDTH/2, 0, WIDTH/2, leftTableView.frame.size.height)
            rightTableView.backgroundColor = UIColor.grayColor()
            rightTableView.tag = 2
            rightTableView.delegate = self
            rightTableView.dataSource = self
            rightTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "rightTableView")
            self.view.addSubview(leftTableView)
            self.view.addSubview(rightTableView)
            self.view.addSubview(coverView)
            self.view.bringSubviewToFront(leftTableView)
            self.view.bringSubviewToFront(rightTableView)
            isShow = true
        }else{
            coverView.removeFromSuperview()
            leftTableView.removeFromSuperview()
            rightTableView.removeFromSuperview()
//            coverView.frame = CGRectMake(0, 0, 0, 0)
            isShow = false
        }
        
    }
    @IBAction func goToAdd(sender: AnyObject) {
        print("增加")
        print(loginSign)
        if loginSign == 0 {
            
          self.tabBarController?.selectedIndex = 3

        }else{
            let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
            let vc : UIViewController = mainStoryboard.instantiateViewControllerWithIdentifier("AddView")
            self.navigationController?.pushViewController(vc, animated: true)
            vc.title = "特卖发布"
        }
   
    }
    func tabBarController(tabBarController: UITabBarController, shouldSelectViewController viewController: UIViewController) -> Bool {
        if !viewController.isKindOfClass(MineViewController.self){
        
            if showLogin {
                return false
            }
            let vc = childViewControllers[0] as! UINavigationController
            let controller = MineViewController()
            controller.delegate = self
            controller.navigationController?.navigationBar.hidden = false
            controller.title = "登录"
            vc.pushViewController(controller, animated: true)
            showLogin = true
            return false
        }
        return true
    }
    
    func viewcontrollerDesmiss(){
        showLogin = false
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
