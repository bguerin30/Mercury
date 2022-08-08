#include "RingBuf.h"
#include <stdlib.h>

struct RingBuf
{
    uint8_t *mem;
    size_t max_sz;

    uint32_t len;
    uint32_t head;
    uint32_t tail;

};

struct RingBuf *RingBuf_allocate(uint8_t *mem, size_t sz)
{
    
    struct RingBuf *temp = (struct RingBuf*)calloc(1, sizeof(struct RingBuf));
    
    if(!temp)
    {
        return NULL;
    }

    if(!mem)
    {
        return NULL;
    }

    temp->mem = mem;
    temp->max_sz = sz/sizeof(uint8_t);

    temp->len = 0;
    temp->head = 0;
    temp->tail = 0;     
    
    return temp;
}

int RingBuf_push(struct RingBuf *rbuf, const uint8_t *data, size_t len)
{
    int bytes_pushed = 0;

    for(size_t i = 0; i < len; i++)
    {
        *(rbuf->mem + rbuf->head) = *(data + i);
        rbuf->head++;
        rbuf->len++;
        bytes_pushed++;
    }
    
    return bytes_pushed;
}

int RingBuf_pop(struct RingBuf *rbuf, uint8_t *buf, size_t len)
{
    int bytes_popped = 0;

    for(size_t i = 0; i < len; i++)
    {
        *(buf + i) = *(rbuf->mem + rbuf->tail);
        rbuf->tail++;
        rbuf->len--;
        ++bytes_popped;
    }
    return bytes_popped;
}

int RingBuf_len(struct RingBuf *rbuf)
{
    return rbuf->len;
}