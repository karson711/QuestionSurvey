//
//  QuestionPulishVC.m
//  EasyEducation
//
//  Created by kunge on 16/6/7.
//  Copyright © 2016年 kunge. All rights reserved.
//

#import "QuestionPulishVC.h"

#import "QuestionPublishCell.h"

#define KScreenWidth  [UIScreen mainScreen].bounds.size.width
#define KScreenHeight [UIScreen mainScreen].bounds.size.height

@interface QuestionPulishVC ()

@property (weak, nonatomic) IBOutlet UITableView *questionPulishTable;

@property (nonatomic,strong)NSMutableArray *questionArr;

@property (nonatomic,strong)NSArray *fixamationQuestionArr;//固定问题数组

@end

@implementation QuestionPulishVC

-(NSArray *)fixamationQuestionArr{
    if (_fixamationQuestionArr == nil) {
        _fixamationQuestionArr = @[@{@"type":@3,@"content":@""},@{@"type":@2,@"content":@""},@{@"type":@2,@"content":@""},@{@"type":@0}];
    }
    return _fixamationQuestionArr;
}

-(NSMutableArray *)questionArr{
    if (_questionArr == nil) {
        _questionArr = [NSMutableArray array];
    }
    return _questionArr;
}

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"问卷调查";
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self.questionArr addObject:self.fixamationQuestionArr];
    
    
    [self.questionPulishTable registerNib:[UINib nibWithNibName:@"QuestionPublishCell" bundle:nil] forCellReuseIdentifier:@"questionPublishCell"];
    
}

#pragma mark - Method
-(void)addQuestion:(UIButton *)btn{
    [self.questionArr addObject:self.fixamationQuestionArr];
    NSLog(@"self.questionArr====%@",self.questionArr);
    [self.questionPulishTable reloadData];
}

#pragma mark - questionSurveyTable Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.questionArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   return  [self.questionArr[section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 40;
    }
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == self.questionArr.count-1 && self.questionArr.count > 0) {
        return 80;
    }
    return .1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    QuestionPublishCell *cell = [tableView dequeueReusableCellWithIdentifier:@"questionPublishCell"];
    cell.indexPath = indexPath;
    cell.opertionType = [self.questionArr[indexPath.section][indexPath.row][@"type"]intValue];
    
    //添加选项方法
    [cell setClickAdd:^(NSIndexPath *indexPath) {
        NSDictionary *tempDict = @{@"type":@1,@"content":@""};
        NSMutableArray *tempArr = [self.questionArr[indexPath.section] mutableCopy];
        if (tempArr.count >= 12) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"每个问题最多支持10个选项" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alert show];
        }else{
            [tempArr insertObject:tempDict atIndex:tempArr.count-1];
            [self.questionArr replaceObjectAtIndex:indexPath.section withObject:tempArr];

            [self.questionPulishTable reloadData];
        }
    }];
    
    //input输入内容
    [cell setInputFieldChanged:^(NSString *text, NSIndexPath *indexPath) {
        NSMutableDictionary *dict = self.questionArr[indexPath.section][indexPath.row];
        [dict setObject:text forKey:@"content"];
        [self.questionArr[indexPath.section] replaceObjectAtIndex:indexPath.row withObject:dict];
    }];
    
    //删除选项方法
    [cell setClickDelete:^(NSIndexPath *indexPath) {
        NSMutableArray *tempArr = [self.questionArr[indexPath.section] mutableCopy];
        [tempArr removeObjectAtIndex:indexPath.row];
        [self.questionArr replaceObjectAtIndex:indexPath.section withObject:tempArr];
        [self.questionPulishTable reloadData];
    }];
    
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        UIView *view = [[UIView alloc] init];
        UILabel *questionTitle = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, KScreenWidth-30, 20)];
        questionTitle.text = @"每个问题最多支持10个选项";
        [view addSubview:questionTitle];
        return view;
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == self.questionArr.count-1 && self.questionArr.count > 0) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        UIButton *addQuestionBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, 10, KScreenWidth-30, 40)];
        addQuestionBtn.backgroundColor = [UIColor blueColor];
        [addQuestionBtn setTitle:@"添加问题" forState:UIControlStateNormal];
        [addQuestionBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [addQuestionBtn addTarget:self action:@selector(addQuestion:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:addQuestionBtn];
        
        return view;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
