//
//  PostModel.h
//  HomeAssignmentObjectiveC
//
//  Created by Olga Rudina on 2021-03-31.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PostModel : NSObject

@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSNumber *upvotes;
@property (nonatomic, strong) NSNumber *numComments;
@property (nonatomic, strong) NSString *imageURL;

- (instancetype)initWithDictionary: (NSDictionary *) dictionary;


@end

NS_ASSUME_NONNULL_END
