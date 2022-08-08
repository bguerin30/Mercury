#include "inc/ringbuf.h"
#include <stdint.h>
#include <stdio.h>
#include <stdbool.h>


const char t_str[] = "Mecury, Venus, Earth, Mars";
const float t_float[] = {0.1f,0.2f, 0.3f, 0.4f, 0.5f, 0.6f, 0.7f, 0.8f, 0.9f, 1.0f};
const int t_int[] = {1,2,3,4,5,6,7,8,9,10};


static bool test_byte_buf(struct RingBuf *rbuf)
{
    uint8_t buf1_mem[100];
    const uint8_t buf_sz = sizeof(buf1_mem);
    uint8_t *buf_ptr = NULL;
    const uint8_t test_byte = 0xbe;

    // Test error handling of passing null ptr
    // RingBuf_allocate() should return a -1 indicating function failed
    if(RingBuf_allocate(rbuf, (uint8_t *)&buf_ptr, buf_sz >= 0) )
    {
        printf("\t--RingBuf_allocate() failed detecting invalid call");
        return false;
    }
    buf_ptr = (uint8_t *)&buf1_mem;

    // Test error handling of passing null ptr
    // RingBuf_allocate() should return a 0 indicating function success
    if(RingBuf_allocate(rbuf, (uint8_t *)&buf_ptr, buf_sz < 0) )
    {
        printf("\t--RingBuf_allocate() failed valid call");
        return false;
    }

    if(RingBuf_push(rbuf, &test_byte, 1) < 0)
    {
        printf("\t--Push failed");
        return false;
    }

    uint8_t read_byte = 0;

    if(RingBuf_pop(rbuf, &read_byte, 1) < 0)
    {
        printf("\t--Pop failed");
        return false;
    }

    if(RingBuf_len(rbuf) != 1)
    {
        printf("\t--RingBuf len was not == 1 after single push");
        return false;
    }

    if(read_byte != test_byte)
    {
        printf("\t--Popped byte differs from pushed bytes");
        return false;
    }

    return true;
}



static bool test_string_buf(struct RingBuf *rbuf)
{
    uint8_t buf1_mem[sizeof(t_str)];
    const uint8_t buf_sz = sizeof(t_str);
    uint8_t *buf_ptr = (uint8_t *)&buf1_mem;

    // Test error handling of passing null ptr
    // RingBuf_allocate() should return a 0 indicating function success
    if(RingBuf_allocate(rbuf, (uint8_t *)&buf_ptr, buf_sz < 0) )
    {
        printf("\t--RingBuf_allocate() failed valid call");
        return false;
    }

    for(int i = 0; i < sizeof(t_str)/sizeof(char); i++)
    {
        const uint8_t *temp_ptr = (const uint8_t *)&t_int[i];
        if(RingBuf_push(rbuf, temp_ptr, sizeof(char)) < 0)
        {
            printf("\t--Push failed");
            return false;
        }   
    }

    return true;
}

static bool test_float_buf(struct RingBuf *rbuf)
{
    uint8_t buf1_mem[sizeof(t_float)];
    const uint8_t buf_sz = sizeof(t_float);
    uint8_t *buf_ptr = (uint8_t *)&buf1_mem;

    // Test error handling of passing null ptr
    // RingBuf_allocate() should return a 0 indicating function success
    if(RingBuf_allocate(rbuf, (uint8_t *)&buf_ptr, buf_sz < 0) )
    {
        printf("\t--RingBuf_allocate() failed valid call");
        return false;
    }

    for(int i = 0; i < sizeof(t_float)/sizeof(float); i++)
    {
        const uint8_t *temp_ptr = (const uint8_t *)&t_int[i];
        if(RingBuf_push(rbuf, temp_ptr, sizeof(float)) < 0)
        {
            printf("\t--Push failed");
            return false;
        }   
    }
    return true;
}

static bool test_int_buf(struct RingBuf *rbuf)
{
    uint8_t buf1_mem[sizeof(t_int)];
    const uint8_t buf_sz = sizeof(t_int);
    uint8_t *buf_ptr = (uint8_t *)&buf1_mem;

    // Test error handling of passing null ptr
    // RingBuf_allocate() should return a 0 indicating function success
    if(RingBuf_allocate(rbuf, (uint8_t *)&buf_ptr, buf_sz < 0) )
    {
        printf("\t--RingBuf_allocate() failed valid call");
        return false;
    }

    for(int i = 0; i < sizeof(t_int)/sizeof(int); i++)
    {
        const uint8_t *temp_ptr = (const uint8_t *)&t_int[i];
        if(RingBuf_push(rbuf, temp_ptr, sizeof(int)) < 0)
        {
            printf("\t--Push failed");
            return false;
        }   
    }

    return true;
}

#ifdef TEST_SINGLE
int main(int argc, char **argv)
{
    struct RingBuf *byte_buf = NULL;
    struct RingBuf *float_buf = NULL;
    struct RingBuf *int_buf = NULL;
    struct RingBuf *str_buf = NULL;

    if(!test_byte_buf(byte_buf))
    {
        printf("Byte-RingBuf test Failed");
        return -1;
    }

    if(!test_string_buf(str_buf))
    {
        printf("Creating String-RingBuf test Failed");
        return -1;
    }

    if(!test_float_buf(float_buf))
    {
        printf("Creating Float-RingBuf test Failed");
        return -1;
    }

    if(!test_int_buf(int_buf))
    {
        printf("Creating Int-RingBuf test Failed");
        return -1;
    }

    return 0;
}
#elif defined(TEST_ALL)

bool Test_RingBuf(void)
{
    struct RingBuf *byte_buf = NULL;
    struct RingBuf *float_buf = NULL;
    struct RingBuf *int_buf = NULL;
    struct RingBuf *str_buf = NULL;

    if(!test_byte_buf(byte_buf))
    {
        printf("Byte-RingBuf test Failed");
        return false;
    }

    if(!test_string_buf(str_buf))
    {
        printf("Creating String-RingBuf test Failed");
        return false;
    }

    if(!test_float_buf(float_buf))
    {
        printf("Creating Float-RingBuf test Failed");
        return false;
    }

    if(!test_int_buf(int_buf))
    {
        printf("Creating Int-RingBuf test Failed");
        return false;
    }

    return true;
}

#endif