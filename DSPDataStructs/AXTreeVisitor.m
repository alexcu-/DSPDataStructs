#import "AXTreeVisitor.h"
// Postfix and Prefix order visitor
@implementation AXTreeVisitor
-(void) visit:(id)key
{
  NSLog(@"%@", key);
}
// Extension behaviour does nothing
-(void) preVisit:(id)key {}
-(void) postVisit:(id)key {}
@end
@implementation AXPreOrderTreeVisitor
-(void) preVisit:(id)key
{
  [super visit:key];
}
@end
@implementation AXPostOrderTreeVisitor
-(void) postVisit:(id)key
{
  [super visit:key];
}
@end