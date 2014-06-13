#import <Foundation/Foundation.h>
@interface AXStaticQueue : NSObject
{
  NSMutableArray* _elements;
  NSUInteger      _maxCount;
}

- (id)   initWithMaxCount:(NSInteger)maxCount;
- (void) enqueue:(id) element;
- (id)   dequeue;

@property (getter = isEmpty, readonly)  BOOL        isEmpty;
@property (readonly)                    NSUInteger  count;

@end