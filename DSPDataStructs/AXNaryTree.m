#import "AXNaryTree.h"
#import "AXTreeVisitor.h"
#import "AXStaticQueue.h"

static AXNaryTree* null;
@implementation AXNaryTree
+ (void)initialize
{
  if (self == [AXNaryTree class])
  {
    null = [[AXNaryTree alloc] init];
    null->_maxCount = 0;
    null->_key = (id)0;
    null->_nodes = [NSMutableArray array];
  }
}
+(AXNaryTree*) null
{
  return null;
}

-(BOOL) isEmpty
{
  return self == [AXNaryTree null];
}

-(id) initWithMaxCount:(NSUInteger)count withKey:(id) key
{
  NSAssert(![key isKindOfClass:[self class]], @"Cannot set key to a node");
  if (self = [super init])
  {
    _key = key;
    _nodes = [NSMutableArray array];
    _maxCount = count;
    // Init with null nodes
    for (int i = 0; i < _maxCount; i++)
      _nodes[i] = [AXNaryTree null];
  }
  return self;
}

-(void) attachNode:(AXNaryTree *)node atIndex:(NSUInteger)idx
{
  NSAssert(idx <= _maxCount, @"Index out of bounds");
  NSAssert(![self isEmpty],  @"Cannot add to null tree");
  // Cannot attch self!
  NSAssert(node != self, @"Cannot attach self node to self");
  _nodes[idx] = node;
}

-(AXNaryTree*) detachNodeAtIndex:(NSUInteger)idx
{
  NSAssert(idx <= _maxCount, @"Index out of bounds");
  NSAssert(![self isEmpty],  @"Cannot detach from null tree");
  // Get a copy back
  AXNaryTree* retVal = [_nodes[idx] copy];
  // Replace with null
  _nodes[idx] = [AXNaryTree null];
  return retVal;
}

// Subscript methods

-(id) objectAtIndexedSubscript:(NSUInteger)idx
{
  NSAssert(idx <= _maxCount, @"Index out of bounds");
  NSAssert(![self isEmpty],  @"Cannot read from null tree");
  return _nodes[idx];
}

-(void) setObject:(id)obj atIndexedSubscript:(NSUInteger)idx
{
  NSAssert([obj isKindOfClass:[self class]], @"Object provided is not a node");
  [self attachNode:obj atIndex:idx];
}

// Traversal methods
- (void) performDepthFirstTraversal:(AXTreeVisitor *)visitor
{
  // Cannot traverse empty tree (i.e., terminates here)
  if (![self isEmpty])
  {
    // Visit key BEFORE traversal
    [visitor preVisit:_key];
    for (AXNaryTree* node in _nodes)
    {
      // Now traverse the subtree with the same visitor
      [node performDepthFirstTraversal:visitor];
    }
    // Visit key AFTER traversal
    [visitor postVisit:_key];
  }
}

-(void) performBreadthFirstTraversal:(AXTreeVisitor *)visitor
{
  #warning Use Fast 16 MAX for now... (haven't yet implemented dynamic stack)
  AXStaticQueue* traverseQueue = [[AXStaticQueue alloc] initWithMaxCount:INT_FAST16_MAX];

  // Enqueue this tree if it's not empty
  if (![self isEmpty])
    [traverseQueue enqueue:self];
  
  // Keep iterating while the traverseQueue is not empty
  while (![traverseQueue isEmpty])
  {
    // Pull out the last in tree
    AXNaryTree* root = [traverseQueue dequeue];
    // Visit the root if not empty
    if (![root isEmpty])
      [visitor visit:root->_key];
    
    // Now enqueue each of the non-null subtrees of the current root
    for (AXNaryTree* subtree in root->_nodes)
      if (![subtree isEmpty])
        [traverseQueue enqueue:subtree];
  }
}

// Copy constructor equivalent
-(id) copyWithZone:(NSZone *)zone
{
  AXNaryTree* copy = [[AXNaryTree alloc] initWithMaxCount:_maxCount withKey:[_key copy]];
  for (int i = 0; i < _maxCount; i++)
  {
    // Was a null tree? Just set to null...
    if ([_nodes[i] isEmpty])
      copy->_nodes[i] = [AXNaryTree null];
    // Else recursively copy...
    else
      copy->_nodes[i] = [_nodes[i] copy];
  }
  return copy;
}

@end