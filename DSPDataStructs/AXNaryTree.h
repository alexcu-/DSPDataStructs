#import <Foundation/Foundation.h>
// Forward declare the tree visitor
@class AXTreeVisitor;
@interface AXNaryTree : NSObject <NSCopying>
{
  NSMutableArray*   _nodes;
  id                _key;
  NSUInteger        _maxCount;
}

- (id) initWithMaxCount:(NSUInteger)count withKey:(id) key;
+ (AXNaryTree*) null;

- (void) attachNode:(AXNaryTree*) node atIndex:(NSUInteger) idx;
- (AXNaryTree*) detachNodeAtIndex:(NSUInteger) idx;

// Subscripting
- (id)objectAtIndexedSubscript:(NSUInteger)idx;
- (void)setObject:(id)obj atIndexedSubscript:(NSUInteger)idx;

// Traversal
- (void) performDepthFirstTraversal:(AXTreeVisitor*) visitor;
- (void) performBreadthFirstTraversal:(AXTreeVisitor*) visitor;

@property (getter = isEmpty, readonly) BOOL empty;

@end