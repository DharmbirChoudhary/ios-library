
#import "UADeviceRegistrationPayload.h"
#import "UA_SBJsonWriter.h"

UAPushJSONKey UAPushMultipleTagsJSONKey = @"tags";
UAPushJSONKey UAPushSingleTagJSONKey = @"tag";
UAPushJSONKey UAPushAliasJSONKey = @"alias";
UAPushJSONKey UAPushQuietTimeJSONKey = @"quiettime";
UAPushJSONKey UAPushTimeZoneJSONKey = @"tz";
UAPushJSONKey UAPushBadgeJSONKey = @"badge";

@interface UADeviceRegistrationPayload()
@property(nonatomic, strong) NSDictionary *payloadDictionary;
@end

@implementation UADeviceRegistrationPayload

- (id)initWithAlias:(NSString *)alias
           withTags:(NSArray *)tags
       withTimeZone:(NSString *)timeZone
      withQuietTime:(NSDictionary *)quietTime
          withBadge:(NSNumber *)badge {

    self = [super init];
    if (self) {
        self.payloadDictionary = [NSMutableDictionary dictionary];

        if (alias) {
            [self.payloadDictionary setValue:alias forKey:UAPushAliasJSONKey];
        }

        if (tags) {
            [self.payloadDictionary setValue:tags forKey:UAPushMultipleTagsJSONKey];
        }

        if (timeZone) {
            [self.payloadDictionary setValue:timeZone forKey:UAPushTimeZoneJSONKey];
        }

        if (quietTime) {
            [self.payloadDictionary setValue:quietTime forKey:UAPushQuietTimeJSONKey];
        }

        if (badge) {
            [self.payloadDictionary setValue:badge forKey:UAPushBadgeJSONKey];
        }
    }

    return self;
}

+ (id)payloadWithAlias:(NSString *)alias
              withTags:(NSArray *)tags
          withTimeZone:(NSString *)timeZone
         withQuietTime:(NSDictionary *)quietTime
             withBadge:(NSNumber *)badge {

    return [[UADeviceRegistrationPayload alloc] initWithAlias:alias
                                                     withTags:tags
                                                 withTimeZone:timeZone
                                                withQuietTime:quietTime
                                                    withBadge:badge];
}

- (NSDictionary *)asDictionary {
    return [self.payloadDictionary copy];
}

- (NSString *)asJSONString {
    UA_SBJsonWriter *writer = [[UA_SBJsonWriter alloc] init];
    return [writer stringWithObject:self.payloadDictionary];
}

- (NSData *)asJSONData {
    return [[self asJSONString]dataUsingEncoding:NSUTF8StringEncoding];
}


@end
