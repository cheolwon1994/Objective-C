//
//  MemoData+CoreDataProperties.m
//  Memo
//
//  Created by dreamtour on 2020/10/23.
//
//

#import "MemoData+CoreDataProperties.h"

@implementation MemoData (CoreDataProperties)

+ (NSFetchRequest<MemoData *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"MemoData"];
}

@dynamic content;
@dynamic insertDate;

@end
