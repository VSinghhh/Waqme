
#import <CoreFoundation/CoreFoundation.h>

@protocol NetworkServiceDelegate
- (void)networkServiceDidFinish:(NSData *)data;
- (void)networkServiceDidError:(NSString *)errorMessage;
@end


@interface NetworkService : NSObject {
	NSURL* url;
	NSURLConnection *urlConnection;

	id<NetworkServiceDelegate> delegate;
	
	NSString *userName;
	NSString *password;
	
	NSMutableData *webData;
    NSString *sampleproperty;
    NSString *webMethod;
    NSString *webMetQueryString;
    int sampleintprop;
}

@property (nonatomic, assign) id <NetworkServiceDelegate> delegate;
@property (nonatomic, retain)  NSString *samplepropert;
@property (nonatomic, assign) int sampleintprop;
@property (nonatomic, retain) NSString *userName;
@property (nonatomic, retain) NSString *password;
@property (nonatomic, retain) NSURL *url;
@property (nonatomic, retain) NSString *webMethod;
@property (nonatomic, retain) NSString *webMetQueryString;

- (id)initWithURL:(NSURL*)serviceURL;
- (void)sendRequest:(NSString*) bodyText requestType:(bool)requestType;
- (void)cancelRequest;

@end