//
//  QuestionPublishCell.m
//  EasyEducation
//
//  Created by kunge on 16/6/7.
//  Copyright © 2016年 kunge. All rights reserved.
//

#import "QuestionPublishCell.h"

@implementation QuestionPublishCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self.inputField addTarget:self action:@selector(inputAction:) forControlEvents:UIControlEventValueChanged];
}

-(void)inputAction:(UITextField *)field{
    if (self.inputFieldChanged) {
        self.inputFieldChanged(field.text,self.indexPath);
    }
}

-(void)setOpertionType:(QuestionOpertionType)opertionType{
    _opertionType = opertionType;
    if (opertionType == OptionType) {
        self.addlabel.hidden = YES;
        self.typeBtn.hidden = NO;
        self.inputField.hidden = NO;
        self.typeBtnWidth.constant = 30;
        self.inputField.placeholder = [NSString stringWithFormat:@"选项%ld",(long)self.indexPath.row];
        [self.typeBtn setImage:[UIImage imageNamed:@"img_x-1"] forState:UIControlStateNormal];
        [self.typeBtn removeTarget:self action:@selector(addAction) forControlEvents:UIControlEventTouchUpInside];
        [self.typeBtn addTarget:self action:@selector(deleteAction) forControlEvents:UIControlEventTouchUpInside];
    }else if (opertionType == FixationOptionType){
        //固定输入选项
        self.addlabel.hidden = YES;
        self.inputField.hidden = NO;
        self.inputField.placeholder = [NSString stringWithFormat:@"选项%ld",(long)self.indexPath.row];
        self.typeBtnWidth.constant = 0;
        self.typeBtn.hidden = YES;
    }else if (opertionType == AddType){
        //添加选项
        [self.typeBtn setImage:[UIImage imageNamed:@"img_add-1"] forState:UIControlStateNormal];
        self.inputField.hidden = YES;
        self.typeBtn.hidden = NO;
        self.addlabel.hidden = NO;
        self.typeBtnWidth.constant = 30;
        self.addlabel.text = @"添加选项";
        [self.typeBtn removeTarget:self action:@selector(deleteAction) forControlEvents:UIControlEventTouchUpInside];
        [self.typeBtn addTarget:self action:@selector(addAction) forControlEvents:UIControlEventTouchUpInside];
    }else if (opertionType == TitleType){
        //问题标题
        self.inputField.hidden = NO;
        self.addlabel.hidden = YES;
        self.typeBtnWidth.constant = 0;
        self.typeBtn.hidden = YES;
        self.inputField.placeholder = [NSString stringWithFormat:@"问卷%ld标题",self.indexPath.section+1];
    }
}

-(void)deleteAction{
    if (self.clickDelete) {
        self.clickDelete(self.indexPath);
    }
}

-(void)addAction{
    if (self.clickAdd) {
        self.clickAdd(self.indexPath);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
