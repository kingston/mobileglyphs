#import "GLHelperFunctions.h"

CGFloat CGPointDistance(CGPoint pt1, CGPoint pt2)
{
    CGFloat dx = pt2.x - pt1.x;
    CGFloat dy = pt2.y - pt1.y;
    return sqrtf(dx * dx + dy * dy);
}