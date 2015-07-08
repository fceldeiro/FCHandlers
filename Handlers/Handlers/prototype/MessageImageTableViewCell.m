//
//  MessageImageTableViewCell.m
//  Chat
//
//  Created by Fabian Celdeiro on 7/7/15.
//  Copyright (c) 2015 Pager. All rights reserved.
//

#import "MessageImageTableViewCell.h"

@implementation MessageImageTableViewCell


-(id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        
        UIImageView * image = [[UIImageView alloc] init];
        image.translatesAutoresizingMaskIntoConstraints = NO;
        self.image = image;
        [self.contentView addSubview:image];
        
        NSDictionary *views = NSDictionaryOfVariableBindings(image);
        
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[image]-0-|" options:0 metrics:nil views: views]];
          [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[image]-0-|" options:0 metrics:nil views: views]];
        
        
        
    }
    
    return self;
}
@end
