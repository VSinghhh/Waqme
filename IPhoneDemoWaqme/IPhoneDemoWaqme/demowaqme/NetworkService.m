

#import "NetworkService.h"


@implementation NetworkService

@synthesize delegate,sampleintprop,samplepropert,userName,password,url,webMethod,webMetQueryString;

- (id) initWithURL:(NSURL*)serviceURL {
    if(self = [super init]){
        [self setUrl:serviceURL];
    }
    
    return self;
}

- (void) sendRequest:(NSString*)bodyText requestType:(bool)pIsPostRequest {
    NSLog(@"final URL in service: %@", url);
    NSLog(@"final Body Data: %@", bodyText);
    
    
    if(self.url == nil) {
        [delegate networkServiceDidError:@""];
        return;
    }
    
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    
    if(pIsPostRequest) {
        bodyText = [bodyText stringByReplacingOccurrencesOfString:@" " withString:@"%20"];

       [theRequest setHTTPMethod:@"POST"];
        NSData *data = [bodyText dataUsingEncoding:NSUTF8StringEncoding];
        [theRequest setHTTPBody:data];
        
        
    }  else {
        
        [theRequest setHTTPMethod:@"GET"];
        
        
        
    }
    
    [theRequest setTimeoutInterval:300];
    
    
    if (urlConnection != nil) {
        [urlConnection cancel];
        [urlConnection release];
        urlConnection= nil;
    }
    urlConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self]  ;
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    

    
    
    //[theRequest setValue:@"application/xml; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    //[theRequest setValue:@"*/*" forHTTPHeaderField:@"Accept"];
    
    /*[theRequest setValue:@"ISO-8859-1,utf-8;q=0.7,*;q=0.7" forHTTPHeaderField:@"Accept-Charset"];
    [theRequest setValue:@"gzip,deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [theRequest setValue:[NSString stringWithFormat:@"%d", [bodyText length]] forHTTPHeaderField:@"Content-Length"];
    [theRequest setTimeoutInterval:200];
        NSLog(@"ContentLength%d",[bodyText length]);

   
    if (urlConnection != nil) {
        [urlConnection cancel];
        [urlConnection release];
        urlConnection= nil;
    }
    
   
    urlConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self]  ;
   // urlConnection
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];*/
    
    
    
}

- (void) cancelRequest {
	
	if (urlConnection) {
		[urlConnection cancel];
		[urlConnection release];
		urlConnection = nil;
		[webData release];
		webData = nil;
	}
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];

}


#pragma mark -
#pragma mark NSURLConnection delegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;

    //NSLog(@"didReceiveResponse= %d",[httpResponse statusCode]);
    //NSLog(@"didReceiveResponse= %@",response.description);

    if ([httpResponse statusCode] == 200 || [httpResponse statusCode]==405) {
        if (webData) {
            [webData release];
            webData = nil;
        }
        //NSLog(@"[httpResponse statusCode] == 200");
        webData = [[NSMutableData alloc] init];
    } else {
        [delegate networkServiceDidError:[NSString stringWithFormat:@"HTTPStatusCode: @%d",[httpResponse statusCode]]];
    }
}


-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    if (webData != nil) {
        [webData appendData:data];
    }	
}

- (void)connection:(NSURLConnection *)connection   didSendBodyData:(NSInteger)bytesWritten
 totalBytesWritten:(NSInteger)totalBytesWritten
totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite {
//    NSLog(@"bytesWritten %d",bytesWritten);
//    NSLog(@"totalBytesWritten %d",totalBytesWritten);
//
//    NSLog(@"totalBytesExpectedToWrite %d",totalBytesExpectedToWrite);

}


- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	[webData release];
	 webData = nil;
	[urlConnection release];
	urlConnection = nil;
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	//NSLog(@"NetworkService: %@", [error localizedDescription]);
	//notify
	[delegate networkServiceDidError:[error localizedDescription]];
    
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	[urlConnection release];
	urlConnection = nil;
    //NSLog(@"connectionDidFinishLoading");

    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    if (webData) {
       
        NSString* str = [[[NSString alloc] initWithData:webData encoding:NSUTF8StringEncoding] autorelease];
        NSLog(@"Response List %@",str);

        
        [delegate networkServiceDidFinish:webData];        
        [webData release];
         webData = nil;
    }
}

- (void) dealloc {
	[webData release];
	[userName release];
	[password release];
	[urlConnection release];
	[url release];
	[super dealloc];
}

@end