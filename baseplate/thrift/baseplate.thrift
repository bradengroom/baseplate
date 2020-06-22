namespace py baseplate.thrift
namespace go reddit.baseplate
namespace java com.reddit.baseplate

/**A raw authentication token as returned by the authentication service.

*/
typedef string AuthenticationToken

/** A two-character ISO 3166-1 country code

*/
typedef string CountryCode

/** An integer measuring the number of milliseconds of UTC time since epoch.

*/
typedef i64 TimestampMilliseconds

/** The base for any baseplate-based service.

Your service should inherit from this one so that common tools can interact
with any expected interfaces.

*/
service BaseplateService {
    /** Return whether or not the service is healthy.

    The healthchecker (baseplate.server.healthcheck) expects this endpoint to
    exist so it can determine your service's health.

    This should return True if the service is healthy. If the service is
    unhealthy, it can return False or raise an exception.

    */
    bool is_healthy(),
}


/** The components of the Reddit LoID cookie that we want to propagate between
services.

This model is a component of the "Edge-Request" header.  You should not need to
interact with this model directly, but rather through the EdgeRequestContext
interface provided by baseplate.

*/
struct Loid {
    /** The ID of the LoID cookie.

    */
    1: string id;
    /** The time when the LoID cookie was created in epoch milliseconds.

    */
    2: i64 created_ms;
}

/** The components of the Reddit Session tracker cookie that we want to
propagate between services.

This model is a component of the "Edge-Request" header.  You should not need to
interact with this model directly, but rather through the EdgeRequestContext
interface provided by baseplate.

*/
struct Session {
    /** The ID of the Session tracker cookie.

    */
    1: string id;
}

/** The components of the device making a request to our services that we want to
propogate between services.

This model is a component of the "Edge-Request" header.  You should not need to
interact with this model directly, but rather through the EdgeRequestContext
interface provided by baseplate.

*/
struct Device {
    /** The ID of the device.

    */
    1: string id;
}

/** Metadata about the origin service for a request.

The "origin" service is the service responsible for handling the request from
the client.

This model is a component of the "Edge-Request" header.  You should not need to
interact with this model directly, but rather through the EdgeRequestContext
interface provided by baseplate.
*/
struct OriginService {
    /** The name of the origin service.

    */
    1: string name
}

/** Geolocation data from a request to our services that we want to
propagate between services.

This model is a component of the "Edge-Request" header.  You should not need to
interact with this model directly, but rather through the EdgeRequestContext
interface provided by baseplate.

*/
struct Geolocation {
    /** The country code of the requesting client.
    */
    1: CountryCode country_code
}

/** Container model for the Edge-Request context header.

Baseplate will automatically parse this from the "Edge-Request" header and
provides an interface that wraps this Thrift model.  You should not need to
interact with this model directly, but rather through the EdgeRequestContext
interface provided by baseplate.

*/
struct Request {
    1: Loid loid;
    2: Session session;
    3: AuthenticationToken authentication_token;
    4: Device device;
    5: OriginService origin_service;
    6: Geolocation geolocation;
}
