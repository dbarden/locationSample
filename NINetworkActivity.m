//
// Copyright 2011 Jeff Verkoeyen
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

#import "NINetworkActivity.h"

#import "NIDebuggingTools.h"

#ifdef DEBUG
#import "NIRuntimeClassModifications.h"
#endif

#import <pthread.h>

static int              gNetworkTaskCount = 0;
static pthread_mutex_t  gMutex = PTHREAD_MUTEX_INITIALIZER;

///////////////////////////////////////////////////////////////////////////////////////////////////
void NINetworkActivityTaskDidStart(void) {
  pthread_mutex_lock(&gMutex);

  BOOL enableNetworkActivityIndicator = (0 == gNetworkTaskCount);

  ++gNetworkTaskCount;

  if (enableNetworkActivityIndicator) {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
  }

  pthread_mutex_unlock(&gMutex);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
void NINetworkActivityTaskDidFinish(void) {
  pthread_mutex_lock(&gMutex);

  --gNetworkTaskCount;
  // If this asserts, you don't have enough stop requests to match your start requests.
  NIDASSERT(gNetworkTaskCount >= 0);
  gNetworkTaskCount = MAX(0, gNetworkTaskCount);

  if (gNetworkTaskCount == 0) {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
  }

  pthread_mutex_unlock(&gMutex);
}


#pragma mark -
#pragma mark Network Activity Debugging

#ifdef DEBUG

static BOOL gNetworkActivityDebuggingEnabled = NO;

void NISwizzleMethodsForNetworkActivityDebugging(void);

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation UIApplication (NimbusNetworkActivityDebugging)


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)nimbusDebugSetNetworkActivityIndicatorVisible:(BOOL)visible {
  // This method will only be used when swizzled, so this will actually call
  // setNetworkActivityIndicatorVisible:
  [self nimbusDebugSetNetworkActivityIndicatorVisible:visible];

  // Sanity check that this method isn't being called directly when debugging isn't enabled.
  NIDASSERT(gNetworkActivityDebuggingEnabled);

  // If either of the following assertions fail then you should look at the call stack to
  // determine what code is erroneously calling setNetworkActivityIndicatorVisible: directly.
  if (visible) {
    // The only time we should be enabling the network activity indicator is when the task
    // count is one.
    NIDASSERT(1 == gNetworkTaskCount);

  } else {
    // The only time we should be disabling the network activity indicator is when the task
    // count is zero.
    NIDASSERT(0 == gNetworkTaskCount);
  }
}


@end


///////////////////////////////////////////////////////////////////////////////////////////////////
void NISwizzleMethodsForNetworkActivityDebugging(void) {
  NISwapInstanceMethods([UIApplication class],
                        @selector(setNetworkActivityIndicatorVisible:),
                        @selector(nimbusDebugSetNetworkActivityIndicatorVisible:));
}


///////////////////////////////////////////////////////////////////////////////////////////////////
void NIEnableNetworkActivityDebugging(void) {
  if (!gNetworkActivityDebuggingEnabled) {
    gNetworkActivityDebuggingEnabled = YES;
    NISwizzleMethodsForNetworkActivityDebugging();
  }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
void NIDisableNetworkActivityDebugging(void) {
  if (gNetworkActivityDebuggingEnabled) {
    gNetworkActivityDebuggingEnabled = NO;
    NISwizzleMethodsForNetworkActivityDebugging();
  }
}


#else // #ifndef DEBUG


///////////////////////////////////////////////////////////////////////////////////////////////////
void NIEnableNetworkActivityDebugging(void) {
  // No-op
}


///////////////////////////////////////////////////////////////////////////////////////////////////
void NIDisableNetworkActivityDebugging(void) {
  // No-op
}


#endif // #ifdef DEBUG
