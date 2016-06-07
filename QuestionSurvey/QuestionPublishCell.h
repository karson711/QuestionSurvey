//
//  QuestionPublishCell.h
//  EasyEducation
//
//  Created by kunge on 16/6/7.
//  Copyright © 2016年 kunge. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuestionPublishCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *typeBtn;
@property (weak, nonatomic) IBOutlet UITextField *inputField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *typeBtnWidth;
@property (weak, nonatomic) IBOutlet UILabel *addlabel;

@property (nonatomic)QuestionOpertionType opertionType;

@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, copy) void (^clickDelete)(NSIndexPath *indexPath);

@property (nonatomic, copy) void (^clickAdd)(NSIndexPath *indexPath);

@property (nonatomic, copy)void (^inputFieldChanged)(NSString * text,NSIndexPath *indexPath);

@end
