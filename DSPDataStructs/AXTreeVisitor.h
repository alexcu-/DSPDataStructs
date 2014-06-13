#import <Foundation/Foundation.h>
@interface AXTreeVisitor : NSObject
// Default behaviour
-(void) visit:(id) key;
// Extended behaviour for subclasses
-(void) preVisit:(id) key;
-(void) postVisit:(id) key;
@end
// Create extended classes
@interface AXPreOrderTreeVisitor  : AXTreeVisitor
@end
@interface AXPostOrderTreeVisitor : AXTreeVisitor
@end