//
//  XKAnnotationView.h
//  JZFP_GS
//
//  Created by 董向坤 on 2018/10/30.
//  Copyright © 2018 xiao_kun. All rights reserved.
//

#import <BaiduMapAPI_Map/BMKMapComponent.h>


NS_ASSUME_NONNULL_BEGIN

@interface XKAnnotationView : BMKAnnotationView

- (id)initWithAnnotation:(id<BMKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier customView:(UIView *)detailView WithData:(NSDictionary *)dataDict WithTag:(NSInteger)tag;


@end

NS_ASSUME_NONNULL_END
