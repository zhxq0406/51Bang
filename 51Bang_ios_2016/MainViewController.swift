//
//  MainViewController.swift
//  51Bang_ios_2016
//
//  Created by apple on 16/6/18.
//  Copyright © 2016年 校酷网络科技公司. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
var address:String  = ""
class MainViewController: UIViewController,CityViewControllerDelegate,CLLocationManagerDelegate,MKMapViewDelegate,UIAlertViewDelegate,UITextFieldDelegate,UINavigationControllerDelegate {
    private var locationView = MKMapView()
    
    var longitude = String()
    var latitude = String()
    
    @IBOutlet weak var scrollView: UIScrollView!
    var cityController:CityViewController!
    //定位管理者
    var locationManager = CLLocationManager()
    var geocoder = CLGeocoder()
    let objectAnnotation = MKPointAnnotation()
    var cityName = String()
    var administrativeArea = String()
    var thoroughfare = String()
    var subLocality = String()
    @IBOutlet var location: UIButton!
    @IBOutlet weak var topView: UIView!
    let nameArr:[String] = ["帮我","我帮","同城互动"]
    let imageArr = ["ic_bangwo","ic_wobang","ic_tongchenghudong"]
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.tabBarController?.tabBar.hidden = false
        self.navigationController?.navigationBar.hidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 0...2 {
            let helpBtn = UIButton(frame: CGRectMake(WIDTH/6-25+WIDTH/3*CGFloat(i), 15, 50, 50))
            helpBtn.layer.cornerRadius = 25
            helpBtn.setImage(UIImage(named: imageArr[i]), forState: UIControlState.Normal)
            helpBtn.tag = i
            helpBtn.addTarget(self, action: #selector(self.helpWithWho(_:)), forControlEvents: .TouchUpInside)
            topView.addSubview(helpBtn)
            let nameLab = UILabel(frame: CGRectMake(WIDTH/6-25+WIDTH/3*CGFloat(i), 70, 50, 20))
            nameLab.textAlignment = .Center
            nameLab.font = UIFont.systemFontOfSize(12)
            nameLab.text = nameArr[i]
            topView.addSubview(nameLab)
            
            
        }
        //创建位置管理器
        //        self.locationManager = CLLocationManager.init()
        locationManager.delegate = self
        locationManager.distanceFilter = CLLocationDistanceMax
        //制定需要的精度级别
        locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        //启动位置管理器
        locationManager.startUpdatingLocation()
        locationManager.requestAlwaysAuthorization()
        
        let status = CLLocationManager.authorizationStatus()
        if status == .NotDetermined {
            let alert = UIAlertView.init(title: "温馨提示", message: "您需要开启定位服务,请到设置->隐私,打开定位服务", delegate: self, cancelButtonTitle: "确定", otherButtonTitles:"取消")
            alert.show()
        }else if (status == .AuthorizedAlways || status == .AuthorizedWhenInUse){
            self.locationManager.startUpdatingLocation()
        }else{
            let alert = UIAlertView.init(title: "温馨提示", message: "定位服务授权失败,请检查您的定位设置", delegate: self, cancelButtonTitle: "确定", otherButtonTitles:"取消")
            alert.show()
            
        }
        
        locationView = MKMapView(frame: CGRectMake(0, 100, WIDTH, HEIGHT-214))
        locationView.delegate = self
        self.scrollView.addSubview(locationView)
        locationView.mapType = .Standard
        locationView.showsUserLocation = true
        //        let latdelta = 0.01
        //        let longdelta = 0.01
        //        var currentLocationSpan = MKCoordinateSpan()
        //        currentLocationSpan = MKCoordinateSpanMake(latdelta, longdelta)
        //        //        位置坐标
        //        let center:CLLocation = CLLocation(latitude: 37.528502, longitude: 121.365593)
        //        let currentRegion:MKCoordinateRegion = MKCoordinateRegion(center: center.coordinate, span: currentLocationSpan)
        //
        //        //        设置显示区域
        //        locationView.setRegion(currentRegion, animated: true)
        //
        //        //        创建大头针
        //        let loc = CLLocation.init(latitude: 37.528502, longitude: 121.365593)
        //        let coord:CLLocationCoordinate2D = loc.coordinate
        //        let mypoint = MyPoint.init(coordinate: coord, andTitle: "")
        //        self.locationView.addAnnotation(mypoint)
        
        //        //        设置大头针的显示位置
        //        objectAnnotation.coordinate = CLLocation(latitude: 37.528502, longitude: 121.365593).coordinate
        //
        //        //        设置点击大头针之后的提示
        //        objectAnnotation.title = "1"
        //        //        大头针描述
        //        objectAnnotation.subtitle = "1"
        //
        //
        //        //        添加大头针
        //        locationView.addAnnotation(objectAnnotation)
        //
        // Do any additional setup after loading the view.
    }
    
    
    
    func createAnnotation(latitude:Double,longitude:Double){
        
        
        let latdelta = 0.06
        let longdelta = 0.06
        var currentLocationSpan = MKCoordinateSpan()
        currentLocationSpan = MKCoordinateSpanMake(latdelta, longdelta)
        //        位置坐标
        let center:CLLocation = CLLocation(latitude: latitude, longitude: longitude)
        let currentRegion:MKCoordinateRegion = MKCoordinateRegion(center: center.coordinate, span: currentLocationSpan)
        
        //        设置显示区域
        locationView.setRegion(currentRegion, animated: true)
        //        创建大头针
        let loc = CLLocation.init(latitude: latitude, longitude: longitude)
        let coord:CLLocationCoordinate2D = loc.coordinate
        let mypoint = MyPoint.init(coordinate: coord, andTitle: self.cityName+self.subLocality)
        self.locationView.addAnnotation(mypoint)
        locationView.showsUserLocation = false
        
        //        设置大头针的显示位置
        //       objectAnnotation.coordinate = CLLocation(latitude: latitude, longitude: longitude).coordinate
        
        //        设置点击大头针之后的提示
        //        objectAnnotation.title = "1"
        //        大头针描述
        //        objectAnnotation.subtitle = "1"
        
        
        //        添加大头针
        //        locationView.addAnnotation(objectAnnotation)
        
        
        
        //        //        创建大头针
        //        //let loc = CLLocation.init(latitude: latitude, longitude: longitude)
        //        //let coord:CLLocationCoordinate2D = loc.coordinate
        //        objectAnnotation.coordinate = CLLocation(latitude: latitude, longitude: longitude).coordinate
        ////        let mypoint = MyPoint.init(coordinate: coord, andTitle: "")
        ////        objectAnnotation.title = "点击下单"
        ////        objectAnnotation.subtitle = "点击详情"
        ////        objectAnnotation.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "imagePathClick:"))
        //        self.locationView.addAnnotation(objectAnnotation)
        
    }
    //
    //    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
    //
    //        if annotation is MKUserLocation {
    //            let ID = "anno"
    //            var annoView = mapView.dequeueReusableAnnotationViewWithIdentifier(ID)
    //            if annoView == nil {
    //                annoView = MKPinAnnotationView.init(annotation: annotation, reuseIdentifier: ID)
    //                annoView?.canShowCallout = true
    //                annoView?.calloutOffset = CGPointMake(0, 0)
    //                let title = UILabel()
    //                title.frame = CGRectMake(0, 0, 100, 50)
    //                title.backgroundColor = UIColor.brownColor()
    //                title.text = "发布任务"
    //                //添加单击手势
    //                title.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(MainViewController.titleClick(_:))))
    //                title.userInteractionEnabled = true
    //                let btn = UIButton()
    //                btn.frame = CGRectMake(0, 0, 200, 200)
    //                btn.setTitle("点击下单", forState: UIControlState.Selected)
    //                annoView?.leftCalloutAccessoryView = title
    //                annoView?.rightCalloutAccessoryView = nil
    //            }
    //            return annoView
    //
    //        }
    //
    //       return nil
    //    }
    
    
    //点击手势响应事件
    func titleClick(sender: UIPinchGestureRecognizer){
        print("点击了气泡")
        
        let vc = CommitOrderViewController()
        //self.presentViewController(vc, animated: true, completion: nil)
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
        //        print("=========\(newLocation.coordinate.latitude)")
        //        print(newLocation.coordinate.longitude)
        //        manager.startUpdatingLocation()
        
        
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print(error)
    }
    
    func helpWithWho(btn:UIButton) {
        print(nameArr[btn.tag])
        if btn.tag == 0 {
            
            if loginSign == 0 {
                
                self.tabBarController?.selectedIndex = 3
                
            }else{
                let vc = CommitOrderViewController()
                //let string = self.administrativeArea+self.cityName+self.thoroughfare
                
                print(address)
                vc.cityName = self.cityName
                vc.longitude = self.longitude
                vc.latitude = self.latitude
                vc.address = address
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
        }else if btn.tag == 1{
            let vc = WoBangPageViewController()
            vc.navigationController?.title = "我帮"
            vc.longitude = self.longitude
            vc.latitude = self.latitude
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            let vc = SameCityViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            //            print("同城互动")
        }
        
        
    }
    @IBAction func goToLocation(sender: AnyObject) {
        print("定位")
        cityController = CityViewController(nibName: "CityViewController", bundle: nil)
        cityController.delegate = self
        self.navigationController?.pushViewController(cityController, animated: true)
        
        cityController.title = "定位"
    }
    func selectCity(city: String) {
        location.setTitle(city, forState: UIControlState.Normal)
        location.sizeToFit()
    }
    
    @IBAction func goToFriendList(sender: AnyObject) {
        print("认证帮")
        let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let vc : UIViewController = mainStoryboard.instantiateViewControllerWithIdentifier("FriendView")
        self.navigationController?.pushViewController(vc, animated: true)
        vc.title = "认证帮"
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.first
        self.locationManager.stopUpdatingLocation()
        print("经度＝")
        print(location!.coordinate.latitude)
        print("纬度＝")
        print(location!.coordinate.longitude)
        let geoCoder = CLGeocoder.init()
        geoCoder.reverseGeocodeLocation(locations.last!) { (placemarks, error) in
            
            let mark = placemarks?.last
            if mark != nil{
                self.cityName = (mark?.locality)!
                self.administrativeArea = (mark?.administrativeArea)!
                self.thoroughfare = (mark?.thoroughfare)!
                self.subLocality = (mark?.subLocality)!
                address = self.administrativeArea+self.cityName+self.subLocality
                let ud = NSUserDefaults.standardUserDefaults()
                ud.setObject(self.cityName, forKey: "cityName")
                ud.setObject(self.subLocality, forKey: "subLocality")
                ud.setObject(self.thoroughfare, forKey: "thoroughfare")
                print(mark?.country)
                
                print(self.administrativeArea)
                
                print(self.cityName)
//                print(mark!.subAdministrativeArea)
                print(self.subLocality)
                //                print(mark?.areasOfInterest)
                print(self.thoroughfare)
            }
            self.getCoordinateWithCityName(self.cityName)
            //            print(mark?.subThoroughfare)
        }
        
        
    }
    
    func getCoordinateWithCityName(cityName:String){
        
        let geoCoder = CLGeocoder.init()
        geoCoder .geocodeAddressString(cityName) { (placemarks, error) in
            let mark = placemarks?.first
            print("城市名")
            print(cityName)
            print("经纬度")
            print(mark?.location?.coordinate)
            self.longitude = String(mark?.location?.coordinate.longitude)
            self.latitude = String(mark?.location?.coordinate.latitude)
            let ud = NSUserDefaults.standardUserDefaults()
            ud.setObject(self.latitude, forKey: "latitude")
            ud.setObject(self.longitude, forKey: "longitude")
            //self.createAnnotation((mark?.location?.coordinate.latitude)!, longitude: (mark?.location?.coordinate.longitude)!)
        }
    }
    
    func mapView(mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
        print("地图缩放级别发送改变时")
    }
    
    func mapView(mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        print("地图缩放完毕触法")
        var region = MKCoordinateRegion()
        let centerCoordinate:CLLocationCoordinate2D = mapView.region.center
        region.center = centerCoordinate
        //        设置显示区域
//        locationView.setRegion(region, animated: true)

//        MKCoordinateRegion region;
//        CLLocationCoordinate2D centerCoordinate = mapView.region.center;
//        region.center= centerCoordinate;
        
        
    }
    
    func mapViewWillStartLoadingMap(mapView: MKMapView) {
        print("开始加载地图")
    }
    
    func mapViewDidFinishLoadingMap(mapView: MKMapView) {
        print("地图加载结束")
    }
    
    func mapViewDidFailLoadingMap(mapView: MKMapView, withError error: NSError) {
        print("地图加载失败")
    }
    
    func mapViewWillStartRenderingMap(mapView: MKMapView) {
        print("开始渲染下载的地图块")
    }
    
    func mapViewDidFinishRenderingMap(mapView: MKMapView, fullyRendered: Bool) {
        print("渲染下载的地图结束时调用")
    }
    
    func mapViewWillStartLocatingUser(mapView: MKMapView) {
        print("正在跟踪用户的位置")
    }
    
    func mapViewDidStopLocatingUser(mapView: MKMapView) {
        print("停止跟踪用户的位置")
    }
    
    func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) {
        print("更新用户的位置")
        print(userLocation.coordinate.latitude)
        print(userLocation.coordinate.longitude)
        //let loc = CLLocation.init(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        //let coord:CLLocationCoordinate2D = loc.coordinate
        //        let mypoint = MyPoint.init(coordinate: coord, andTitle: "mypoint")
        //        self.locationView.addAnnotation(mypoint)
        self.locationView.removeAnnotations(self.locationView.annotations)
        self.createAnnotation(userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
    }
    
    func mapView(mapView: MKMapView, didFailToLocateUserWithError error: NSError) {
        print("跟踪用户的位置失败")
    }
    
    func mapView(mapView: MKMapView, didChangeUserTrackingMode mode: MKUserTrackingMode,
                 animated: Bool) {
        print("改变UserTrackingMode")
    }
    
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        print("设置overlay的渲染")
        return MKPolylineRenderer()
    }
    
    func mapView(mapView: MKMapView, didAddOverlayRenderers renderers: [MKOverlayRenderer]) {
        print("地图上加了overlayRenderers后调用")
    }
    
    /*** 下面是大头针标注相关 *****/
    func mapView(mapView: MKMapView, didAddAnnotationViews views: [MKAnnotationView]) {
        print("添加注释视图")
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {
        print("点击注释视图按钮")
    }
    
    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
        print("点击大头针注释视图")
        
    }
    
    func mapView(mapView: MKMapView, didDeselectAnnotationView view: MKAnnotationView) {
        print("取消点击大头针注释视图")
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView,
                 didChangeDragState newState: MKAnnotationViewDragState,
                                    fromOldState oldState: MKAnnotationViewDragState) {
        print("移动annotation位置时调用")
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
