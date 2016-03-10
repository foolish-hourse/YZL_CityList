/** 
 * 使用方法
 * step1:导入YZLCityListTool工具包
 * step2:在需要弹出城市列表的页面头部导入YZLCityTool
 * step3:在这个页面声明一个YZLCityTool属性并初始化
 * step3:在需要弹出城市列表的位置使用YZLCityTool对象调用实例方法- (void)showCityListInVC:(UIViewController *)vc。vc代表当前页面的控制器
 * step4:在这个类中实现YZLCityToolDelegate协议，在代理方法- (void)getSelectedCityName:(NSString *)cityName中能通过cityName取得选择的城市名称。
 */