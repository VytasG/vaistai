//
//  DrugViewCell.h
//  vaistai.lt
//
//  Created by Andriukas on 2010-12-11.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DrugViewCell : UITableViewCell {
	UILabel *title;
	UILabel *price;
	UIImageView *banner;
	UILabel *group;
	
}
@property(nonatomic,retain) UILabel *title;
@property(nonatomic,retain) UILabel *price;
@property(nonatomic,retain) UIImageView *banner;
@property(nonatomic,retain) UILabel *group;
@end
