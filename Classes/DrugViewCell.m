//
//  DrugViewCell.m
//  vaistai.lt
//
//  Created by Andriukas on 2010-12-11.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "DrugViewCell.h"


@implementation DrugViewCell
@synthesize title,price,banner,group;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code.
		self.title = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 280, 44)];
		title.textColor = [UIColor blueColor];
		[self.contentView addSubview:self.price];
		
		self.price = [[UILabel alloc] initWithFrame:CGRectMake(100, 40, 280, 44)];
		self.price.textColor = [UIColor blueColor];
		[self.contentView addSubview:self.price];
		
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state.
}


- (void)dealloc {
    [super dealloc];
}


@end
