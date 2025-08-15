//
//  Malus.h
//  Malus
//
//  Created by Roland Rabien on 2016-01-24.
//  Copyright © 2016 Roland Rabien. All rights reserved.
//
#ifdef __APPLE__
#include <TargetConditionals.h>
#if TARGET_OS_IPHONE
#import <Foundation/Foundation.h>
#elif TARGET_IPHONE_SIMULATOR
#elif TARGET_OS_MAC
#import <Cocoa/Cocoa.h>
#endif
#endif

//! Project version number for Malus.
FOUNDATION_EXPORT double MalusVersionNumber;

//! Project version string for Malus.
FOUNDATION_EXPORT const unsigned char MalusVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <Malus/PublicHeader.h>

#import <Malus/MTSMacros.h>

#import <Malus/NSArray+MTSArray.h>
#import <Malus/NSData+MTSData.h>
#import <Malus/NSDate+MTSDate.h>
#import <Malus/NSFileManager+MTSFileManager.h>
#import <Malus/NSMutableString+MTSMutableString.h>
#import <Malus/NSObject+MTSCast.h>
#import <Malus/NSString+MTSString.h>
#import <Malus/NSValue+MTSValue.h>
#import <Malus/UIAlertView+MTSAlertView.h>
#import <Malus/UIColor+MTSColor.h>
#import <Malus/UIView+MTSLayout.h>
#import <Malus/UIView+MTSRect.h>
#import <Malus/UIView+MTSView.h>
#import <Malus/UIViewController+MTSViewController.h>
#import <Malus/MTSMessageBox.h>
#import <Malus/MTSActionSheet.h>

#import <Malus/MTS2DArray.h>

#import <Malus/MTSLine.h>
#import <Malus/MTSPair.h>
#import <Malus/MTSPoint.h>
#import <Malus/MTSRect.h>

#import <Malus/MTSArchiveReader.h>
#import <Malus/MTSArchiveWriter.h>
#import <Malus/MTSButterworthFilter.h>
#import <Malus/MTSDefaults.h>
#import <Malus/MTSLog.h>
#import <Malus/MTSRollingAverage.h>
#import <Malus/MTSTimer.h>
#import <Malus/MTSUtil.h>
#import <Malus/MTSVideoUtil.h>
#import <Malus/MTSLocationManager.h>
#import <Malus/MTSLocationWatcher.h>

#import <Malus/MTSCPUMeter.h>
#import <Malus/MTSMapBaseView.h>
#import <Malus/MTSMapView.h>
#import <Malus/MTSMapPath.h>
#import <Malus/MTSMapTypes.h>
#import <Malus/MTSMercatorProjection.h>
#import <Malus/MTSProjection.h>
#import <Malus/MTSMapQuestOSMTileProvider.h>
#import <Malus/MTSOpenCycleMapLandscapeTileProvider.h>
#import <Malus/MTSOpenCycleMapTileProvider.h>
#import <Malus/MTSOpenCycleMapTransportTileProvider.h>
#import <Malus/MTSOSMTileProvider.h>
#import <Malus/MTSTileCache.h>
#import <Malus/MTSStamenTerrainTileProvider.h>
#import <Malus/MTSSimpleTableView.h>
#import <Malus/MTSSimpleTableViewController.h>
#import <Malus/MTSSimpleTableViewGroup.h>
#import <Malus/MTSSimpleTableViewItem.h>
#import <Malus/MTSSimpleTableViewItemProtocol.h>
#import <Malus/MTSSimpleTableViewItemDualSlider.h>
#import <Malus/MTSSimpleTableViewItemSlider.h>
#import <Malus/MTSSimpleTableViewItemSwitch.h>
#import <Malus/MTSSimpleTableViewItemCheck.h>
#import <Malus/MTSLabelSlider.h>
#import <Malus/MTSLabelRangeSlider.h>
#import <Malus/MTSTextItem.h>
#import <Malus/MTSTextGrid.h>

#import <Malus/NMRangeSlider.h>
