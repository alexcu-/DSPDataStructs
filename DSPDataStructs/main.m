#import <Foundation/Foundation.h>
#import "AXNaryTree.h"
#import "AXTreeVisitor.h"

int main(int argc, const char * argv[])
{
  const int SIZE = 3;
  AXNaryTree* root = [[AXNaryTree alloc] initWithMaxCount:SIZE withKey:@"A"];
  
  // Attach three subtrees
  
  [root attachNode:[[AXNaryTree alloc] initWithMaxCount:SIZE withKey:@"AA"] atIndex:0];
  [root attachNode:[[AXNaryTree alloc] initWithMaxCount:SIZE withKey:@"AB"] atIndex:1];
  [root attachNode:[[AXNaryTree alloc] initWithMaxCount:SIZE withKey:@"AC"] atIndex:2];

  
  // Attach three subsubtrees
  
  root[0][0] = [[AXNaryTree alloc] initWithMaxCount:SIZE withKey:@"AAA"];
  root[1][0] = [[AXNaryTree alloc] initWithMaxCount:SIZE withKey:@"ABA"];
  root[1][1] = [[AXNaryTree alloc] initWithMaxCount:SIZE withKey:@"ABB"];
  
  NSLog(@"Pre-order traversal:");
  [root performDepthFirstTraversal:[[AXPreOrderTreeVisitor alloc] init]];
  NSLog(@"Post-order traversal:");
  [root performDepthFirstTraversal:[[AXPostOrderTreeVisitor alloc] init]];
  NSLog(@"Breadth-first traversal:");
  [root performBreadthFirstTraversal:[[AXTreeVisitor alloc] init]];
  
  
  return 0;
}

