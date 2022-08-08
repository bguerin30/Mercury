#include "ringbuf.h"

struct RingBuf
{
    uint8_t *mem;
    size_t mem_sz;

    uint32_t len;
    uint32_t head;
    uint32_t tail;

    enum RBUF_STATUS status;

};

enum RBUF_STATUS RingBuf_allocate(struct RingBuf *rbuf, uint8_t *mem, size_t sz)
{
    if(mem == NULL)
    {
        rbuf->status = RBUF_STATUS_ERR_INIT;
    }
    else
    {
        rbuf->mem = mem;
        rbuf->mem_sz = sz;
        rbuf->status = RBUF_STATUS_OK;
    }

    return rbuf->status;
}

enum RBUF_STATUS RingBuf_push(struct RingBuf *rbuf, const uint8_t *data, size_t len)
{
    return rbuf->status;
}

enum RBUF_STATUS RingBuf_pop(struct RingBuf *rbuf, uint8_t *buf, size_t len)
{
    return rbuf->status;
}

uint32_t RingBuf_len(struct RingBuf *rbuf)
{
    return rbuf->len;
}