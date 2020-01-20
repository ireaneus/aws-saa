# AWS-DynamoDB

[Back](README.md) to aws-saa home page

>*A fast and flexible NoSQL database service for all applications that need consistent, single-digit millisecond latency at any scale.  It is a fully managed database and supports both document and key-value data models.  Its flexible data model and reliable performance make it a great fit for mobile, web, gaming, ad-tech, IoT, and many other applications.*

- DynamoDB uses optimistic concurrency control.
- DynamoDB uses conditional writes for consistency.
- Integrates Monitoring
- Integrates with AWS big data services such as Elastic MapReduce and Redshift

>**A secondary index:** *is a data structure that contains a subset of attributes from a table, along with an alternate key to support Query operations. With a secondary index, queries are no longer restricted to the table primary key; you can also retrieve the data using the alternate key defined by the secondary index. A table can have multiple secondary indexes, which gives your applications access to many different query patterns. A local secondary index is an index that has the same hash key as the table, but a different range key*

You can create global and local secondary indexes at the same time you create a table, but you must wait for the first table with a secondary index to become active before creating the next one. Failure to do so produces the “LimitExceededException” error.

## Eventual Consistent Reads (Default)

    Consistency across all copies of data is usually reached within a second.  Repeating a read after a short time should returen the updated data. (Best Read performance)

## Strongly Consistent Reads

    A strongly consistent read returns a result that reflects all writes that received a successful response prior to the read.

## Pricing

### Provisioned Throughput capacity

- write throughput .0065 per hour for every 10 units
- read throughput .0065 per hour for every 50 units
- 1st 25GB stored per month is free
- storage costs of .25 GB per month there after
- Reads are rounded up in 4kb increments
- Eventual Consistent reads consists of 2 reads per second
  - (Size of read rounded to nearest 4kb / 4kb) * # of items = read throughput / 2
- Strongly Consistent Reads consists of 1 read per second
  - (Size of read rounded to nearest 4kb / 4kb) * # of items = read throughput
- Writes are 1kb with 1 write per second
  - 1kb * items
  - 400 HTTP Status code - ProvisionedThroughputExceedException

>**Query** *Gets one or more items using the table primary key, or from a secondary index using the index key. You can narrow the scope of the query on a table by using comparison operators or expressions. You can also filter the query results using filters on non-key attributes. Supports both strong and eventual consistency. A single response has a size limit of 1 MB.*

>**Scan** *Gets all items and attributes by performing a full scan across the table or a secondary index. You can limit the return set by specifying filters against one or more attributes.*

## Primary Keys

### Single Attribute - Partition Key (Hash key) Unique ID

    Partition keys value an input to an internal hash function. Partitions physical location in which data is stored.
    No two items in a table can have the same partition key value

>**Composite** *Partition key and Sort Key (Hash & Range) composed of two Attributes  Unique ID and date Range*

    Two items can have the same partition key but they must have a different sort key.

## Indexes

- Local Secondary Index - same partition key different sort key.
  - Can only be created when creating a table
- Global Secondary Index - different partition key and different sort key
  - Can be created at table creation or later
  - Has its own Provisioned throughput
- Up to 5 global and local indexes per table

## Projected Attributes - up to 20 attributes

    Attributes copied from the table to the index, in addition to the primary key attributes and index key attributes

## ProjectionType

    Keys_only Only the index and primary keys are Projected (smallest index - more performant)
    include - only specified attributes are Projected
    all - all attributes are projected (biggest index - least performant)

## Streams - Used to capture any kind of modification of the DynamoDB tables. 24hrs max stored

- If a new item is added to the table, the stream captures an image of the entire item, including all of its Attributes
- If an item is updated, the stream captures the before and after image of any attributes that were modified in the item
- If an item is deleted from the table the stream captures an image of the entire item before it was deleted.

## Limits

- 256 tables per region - more available upon request
- Partition key length 2048 bytes, 1 byte
- Sort key length 1024 bytes, 1 byte
- Item size 400kb

## Web Identity providers

1. Web Identity token
   - AccessKeyID, SecretAccessKey, SessionToken
   - Expiration
   - AssumeRoleID
   - SubjectFromWebIdentityToken
2. App ID of providers
3. ARN of role

## Conditional Writes

GetItems - updateItem if item=original - indempotent - critical data

## Atomic Counters

not indempotent - not critical data

## BatchGetItem

## Scenarios

*Your design team is about to implement an urgently needed collection and analysis solution. The data you will collect from an array of 50,000 anonymous data collectors will be summarized each day but rarely used again. The data will be pulled from collectors approximately once an hour. The Dev responsible for the DynamoDB design is concerned about how to design the Partition and Local keys to ensure efficient use of the DynamoDB tables. What advice would you provide.*

- Create a new table each day, and reconfigure the old table for infrequent use after the summation is complete.

*You are working with the S3 API and receive an error message: 409 Conflict. What is the possible cause of this error?*

- You're attempting to remove a bucket without emptying the contents of the bucket first.