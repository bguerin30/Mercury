


#ifndef RINGBUF_H__
#define RINGBUF_H__

#include <stdint.h>
#include <stdbool.h>
#include <stddef.h>

enum RBUF_STATUS
{
    RBUF_STATUS_ERR_MEM_OUT_OF_BOUNDS = -3,
    RBUF_STATUS_ERR_OVERFLOW = -2,
    RBUF_STATUS_ERR_INIT = -1,
    RBUF_STATUS_OK = 0
};

enum RBUF_TYPE
{
    RBUF_CHAR8,
    RBUF_INT32,
    RBUF_INT64,
    RBUF_FLOAT32,
    RBUF_FLOAT64,
};

struct RingBuf;

enum RBUF_STATUS RingBuf_allocate(struct RingBuf *rbuf, uint8_t *mem, size_t sz);

enum RBUF_STATUS RingBuf_push(struct RingBuf *rbuf, const uint8_t *data, size_t len);

enum RBUF_STATUS RingBuf_pop(struct RingBuf *rbuf, uint8_t *buf, size_t len);

uint32_t RingBuf_len(struct RingBuf *rbuf); 
#endif /* RINGBUF_H__ */
