//
//  SlackChatViewController.swift
//  Chat
//
//  Created by Fabian Celdeiro on 7/3/15.
//  Copyright (c) 2015 Pager. All rights reserved.
//

import UIKit
import SlackTextViewController
import SDWebImage

class SlackChatTableViewController: SLKTextViewController {

    
    let socketManager = SocketManager(url: "localhost:30000")
    
    static let kCellIdentifierMessenger = "kCellIdentifierMessenger"
    static let kCellIdentifierImage = "kCellIdentifierImage"
    static let kCellIdentifierAutoCompletion = "kCellIdentifierAutoCompletion"

    var targetUserIdentifier:String?
    
    var messages : Array<Event>
    
    init(){
        self.messages = []
        
        super.init(tableViewStyle: UITableViewStyle.Plain)
        
        self.registerClassForTextView(SLKTextView)
    }
    
    init(targetUserIdentifier:String){
        self.targetUserIdentifier = targetUserIdentifier
        self.messages = []
        
        super.init(tableViewStyle: UITableViewStyle.Plain)
        self.commonInit()
    }

    required init(coder:NSCoder){
        self.messages = []
        super.init(coder: coder)
        self.commonInit()
    }
    
    func commonInit(){
        self.registerClassForTextView(SLKTextView)
    }
    
    override class func tableViewStyleForCoder(decoder: NSCoder!) -> UITableViewStyle{
        return UITableViewStyle.Plain
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        socketManager.connect()
        // Do any additional setup after loading the view.
       
        weak var weakSelf  = self;
        
        socketManager.addListener( SocketEvent.Message, owner: self, evaluation: { (event:Event) -> Bool in
            return true
        }) { (event) -> Void in
            weakSelf?.insertEvent(event)
        }
       
        
    
        bounces = true
        shakeToClearEnabled = true
        keyboardPanningEnabled = true
        shouldScrollToBottomAfterKeyboardShows = false
        
        inverted = false
        
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None

        
        tableView.registerClass(MessageTableViewCell.self , forCellReuseIdentifier:SlackChatTableViewController.kCellIdentifierMessenger);
        
        tableView.registerClass(MessageImageTableViewCell.self, forCellReuseIdentifier: SlackChatTableViewController.kCellIdentifierImage)
        
        
        rightButton.setTitle("Send", forState: UIControlState.Normal)
        
        textInputbar.autoHideRightButton = true
        textInputbar.maxCharCount = 255
        textInputbar.counterStyle = SLKCounterStyle.Split
        textInputbar.counterPosition = SLKCounterPosition.Top

        
        leftButton .setImage(UIImage(named: "icn_upload"), forState: UIControlState.Normal)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func insertEvent(message:Event){
        

        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        
        let rowAnimation : UITableViewRowAnimation = self.inverted ? UITableViewRowAnimation.Bottom : UITableViewRowAnimation.Top
        
        let scrollPosition = self.inverted ? UITableViewScrollPosition.Bottom : UITableViewScrollPosition.Top
        
      //  let rowAnimation : UITableViewRowAnimation = UITableViewRowAnimation.None
    //    let scrollPosition = UITableViewScrollPosition.Middle
        
        
        tableView.beginUpdates()
        messages.insert(message, atIndex: 0)
//        messages.append(message)
        tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: rowAnimation)
        tableView.endUpdates()
        
        tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: scrollPosition, animated: true)
        
        tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
    }

    
    override func didPressLeftButton(sender: AnyObject!) {
       
        let payloadImage = PayloadType.Image(payload: PayloadImage(imageURL: NSURL(string: "http://orig09.deviantart.net/b529/f/2013/284/9/1/vegeta_el_principe_saiyajin_by_salvamakoto-d6q1rtm.png")!))
        
        let event = Event(identifier: "me", from: "Fabian", to: self.targetUserIdentifier!, payload: payloadImage)
        
     //   insertEvent(event)
        socketManager.emit(SocketEvent.Message, event: event)
        
        super.didPressLeftButton(sender)

    }
    override func  didPressRightButton(sender: AnyObject!) {

        typingIndicatorView.insertUsername("Ezequiel")

        self.textView .refreshFirstResponder()
        
        let payloadText = PayloadType.Text(payload: PayloadText(text: textView.text))
        let event = Event(identifier: "me", from: "Fabian", to: self.targetUserIdentifier!, payload: payloadText)
        
       // insertEvent(event)
       
        socketManager.emit(SocketEvent.Message, event: event)
        
        super.didPressRightButton(sender)
        
    }
    
    override func  tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
        return self.messageCellForRowAtIndexPath(indexPath)!
    
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        
    
        let eventMessage = self.messages[indexPath.row]
        
        
        switch eventMessage.payload! {
        case .Text(let attachment):
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineBreakMode = NSLineBreakMode.ByWordWrapping
            paragraphStyle.alignment = NSTextAlignment.Left
            
            let attributes = [ NSFontAttributeName : UIFont.systemFontOfSize(16.0),
                NSParagraphStyleAttributeName : paragraphStyle]
            
            let width = CGRectGetWidth(tableView.frame) - kMessageTableViewCellMinimumHeight - 25.0
            
            let titleBounds =  (eventMessage.from! as NSString).boundingRectWithSize(CGSize(width: width, height: CGFloat.max), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: attributes, context: nil)
            
            let bodyBounds = (attachment!.text! as NSString).boundingRectWithSize(CGSize(width: width, height: CGFloat.max), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: attributes, context: nil)
            
            if (attachment!.text! as NSString).length == 0 {
                return 0.0
            }
            
            let height = CGRectGetHeight(titleBounds) + CGRectGetHeight(bodyBounds) + 40.0;
            
            
            if height < kMessageTableViewCellMinimumHeight {
                return kMessageTableViewCellMinimumHeight
            }
            else{
                return height
            }

        case .Image(let image):
            return 120.0
        default:
            return kMessageTableViewCellMinimumHeight
        }
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.messages.count
    }
    
    func messageCellForRowAtIndexPath(indexPath:NSIndexPath) -> UITableViewCell?{
        
        let message = self.messages[indexPath.row]
        
        if let payload = message.payload{
            switch payload{
            case .Text(let textAttachment):
            
                    let  cell = tableView.dequeueReusableCellWithIdentifier(SlackChatTableViewController.kCellIdentifierMessenger) as! MessageTableViewCell
            
                    cell.titleLabel.text = message.from
                    cell.bodyLabel.text = textAttachment?.text
                    cell.indexPath = indexPath
                    cell.usedForMessage = true
                    cell.transform = self.tableView.transform
                    return cell

            case .Image(let imageAttachment):
            
                let cell = tableView.dequeueReusableCellWithIdentifier(SlackChatTableViewController.kCellIdentifierImage) as? MessageImageTableViewCell
                cell?.image.sd_setImageWithURL(imageAttachment?.imageURL)
                cell?.transform = self.tableView.transform

            return cell
            
            default:
                print("hh")
                return nil
            }
        
        }
        else{
            return nil
        }
    }
}
