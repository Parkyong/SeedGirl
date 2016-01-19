//
//  SeedTagData.m
//  SeedSocial
//
//  Created by Admin on 15/4/29.
//  Copyright (c) 2015年 altamob. All rights reserved.
//

#import "SeedTagData.h"
#import "UIColor+Expand.h"

@implementation SeedTagData
@synthesize TagID,TagText,TagTextColor,TagColor;

//设置数据
- (void)setSeedTagData:(id)_data
{
    if(_data == nil)
        return ;
    
    if([_data objectForKey:@"tagid"] != nil)
    {
        TagID = [[_data objectForKey:@"tagid"] integerValue];
    }
    
    if([_data objectForKey:@"tagtitle"] != nil)
    {
        TagText = [NSString stringWithFormat:@"%@",[_data objectForKey:@"tagtitle"]];
    }
    
    if([_data objectForKey:@"tagcolor"] != nil)
    {
        TagTextColor = [NSString stringWithFormat:@"%@",[_data objectForKey:@"tagcolor"]];
        
        NSRange range = [TagTextColor rangeOfString:@"#"];
        if(range.location != NSNotFound) {
            TagTextColor = [TagTextColor substringFromIndex:range.location+1];
        }
        
        TagColor = [UIColor colorWithHexText:TagTextColor];
    }
    return ;
}

#pragma mark - NSCoder

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super init])
    {
        self.TagID = [[aDecoder decodeObjectForKey:@"tag_id"] integerValue];
        self.TagText = [aDecoder decodeObjectForKey:@"tag_text"];
        self.TagTextColor = [aDecoder decodeObjectForKey:@"tag_text_color"];
        self.TagColor = [UIColor colorWithHexText:self.TagTextColor];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:[NSNumber numberWithInteger:self.TagID] forKey:@"tag_id"];
    [aCoder encodeObject:self.TagText forKey:@"tag_text"];
    [aCoder encodeObject:self.TagTextColor forKey:@"tag_text_color"];
}

@end
