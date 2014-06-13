#import "AXStaticQueue.h"

@implementation AXStaticQueue

-(id) initWithMaxCount:(NSInteger)maxCount
{
  if (self = [super init])
  {
    _elements = [NSMutableArray array];
    _maxCount = maxCount;
  }
  return self;
}

-(BOOL) isEmpty
{
  return [_elements count] == 0;
}

-(NSUInteger) count
{
  return [_elements count];
}

-(void) enqueue:(id) element
{
  NSAssert([_elements count] != _maxCount, @"Stack overflow");
  [_elements addObject:element];
}

-(id) dequeue
{
  NSAssert(![self isEmpty], @"Stack underflow");
  // Copy out element
  id retVal = [_elements[0] copy];
  [_elements removeObjectAtIndex:0];
  return retVal;
}

@end