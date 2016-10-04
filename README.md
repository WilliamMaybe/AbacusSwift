# AbacusSwift
第一个swift项目

####IOS9
到此一游

#WilliamZhang

2016-3-6

用SB完成了CheckList里的第三个模块，中间碰到了一些坑，在tableView自动适配高度上，tableView.rowHeight = ....是不起作用的（SB模式下），要在delegate中使用UITableViewAutomaticDimension才有效果，然后国际化的问题在使用SB时也是一个坑，反正是需要多看看才能知道的东西

##Protocol
在使用enum的时候，并不能直接将变量存储到枚举中，所以这个时候便可以使用协议来完成

```
protocol MessageProtocol {
	var message: String { get set }
}

enum MessageContent {
	case .Title(String)
	case .SubTitle(String)
	
	var message: String {
		get {
			case let .Title(x): return x
			case let .SubTitle(x): return x
		}
		
		set {
			case .Title(x): self = .Title(newValue)
			case .SubTitle(x): self = .SubTitle(newValue)
		}
	}
}

```

##Maybe
