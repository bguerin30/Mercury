#include <stdint.h>
#include <stdio.h>
#include <stdbool.h>

#include "RingBuf.h"

const char t_str[] = "Mecury, Venus, Earth, Mars";
const float t_float[] = {0.1f,0.2f, 0.3f, 0.4f, 0.5f, 0.6f, 0.7f, 0.8f, 0.9f, 1.0f};
const int t_int[] = {1,2,3,4,5,6,7,8,9,10};

static bool test_byte_buf(int test_num, struct RingBuf *rbuf);
static bool test_int_buf(struct RingBuf *rbuf);
static bool test_float_buf(struct RingBuf *rbuf);
static bool test_string_buf(struct RingBuf *rbuf);

static bool main_logic(void)
{
    struct RingBuf *byte_buf = NULL;
    struct RingBuf *float_buf = NULL;
    struct RingBuf *int_buf = NULL;
    struct RingBuf *str_buf = NULL;

    if(!test_byte_buf(1,byte_buf))
    {
        printf("Byte-RingBuf test Failed\r\n");
        return -1;
    }
/*
    if(!test_string_buf(str_buf))
    {
        printf("Creating String-RingBuf test Failed\r\n");
        return -1;
    }

    if(!test_float_buf(float_buf))
    {
        printf("Creating Float-RingBuf test Failed\r\n");
        return -1;
    }

    if(!test_int_buf(int_buf))
    {
        printf("Creating Int-RingBuf test Failed\r\n");
        return -1;
    }
*/
    return 1;
}


#ifdef TEST_SINGLE

int main(int argc, char **argv)
{
    return main_logic();
}

#elif defined(TEST_ALL)

bool Test_RingBuf(void)
{
    return main_logic();
}

#endif


static bool test_byte_buf(int test_num, struct RingBuf *rbuf)
{
    uint8_t buf1_mem[100];
    uint8_t small_mem[1];
    uint8_t big_mem[100];

    const size_t buf_sz = sizeof(buf1_mem);
    const uint8_t test_byte = 0xbe;
    uint8_t *buf_ptr;

    int status_code = 0;
    // Test error handling of passing null ptr
    // RingBuf_allocate() should return a -1 indicating function failed
    rbuf = RingBuf_allocate( buf_ptr, buf_sz);
    if(rbuf)
    {
        printf("\t--RingBuf_allocate() failed detecting invalid call\r\n");
        printf("\t\t--errcode[%d]",status_code);
        return false;
    }
    printf("Test [%d] %d/%d PASSED.\r\n",test_num, 1,6);
    

    // Test error handling of passing null ptr
    // RingBuf_allocate() should return a 0 indicating function success
    buf_ptr = (uint8_t *)small_mem;
    rbuf = RingBuf_allocate(buf_ptr, buf_sz);
    if(!rbuf)
    {
        printf("\t--RingBuf_allocate() failed valid call\r\n");
        printf("\t\t--errcode[%d]",status_code);
        return false;
    }
    printf("Test [%d] %d/%d PASSED.\r\n",test_num, 2,6);

    status_code = RingBuf_push(rbuf, &test_byte, sizeof(test_byte));
    if(status_code < sizeof(test_byte))
    {
        printf("\t--Push failed\r\n");
        printf("\t\t--errcode[%d]",status_code);
        return false;
    }
    printf("Test [%d] %d/%d PASSED.\r\n",test_num, 3,6);

    uint8_t read_byte = 0;
    status_code = RingBuf_pop(rbuf, &read_byte, sizeof(read_byte));
    if(status_code < sizeof(read_byte))
    {
        printf("\t--Pop failed\r\n");
        printf("\t\t--errcode[%d]",status_code);
        return false;
    }
    printf("Test [%d] %d/%d PASSED.\r\n",test_num, 4,6);

    if(RingBuf_len(rbuf) != 0)
    {
        printf("\t--RingBuf len was not == 0 after single push+pop\r\n");
        printf("\t\t--errcode[%d]\r\n",status_code);
        return false;
    }

    printf("Test [%d] %d/%d PASSED.\r\n",test_num, 5,6);
    if(read_byte != test_byte)
    {
        printf("\t--Popped byte differs from pushed bytes\r\n");
        printf("\t\t--errcode[%d]\r\n",status_code);
        return false;
    }

    printf("Test [%d] %d/%d PASSED.\r\n",test_num, 6,6);
    return true;
}

static bool test_string_buf(struct RingBuf *rbuf)
{
    uint8_t buf1_mem[sizeof(t_str)];
    const uint8_t buf_sz = sizeof(t_str);
    uint8_t *buf_ptr = (uint8_t *)&buf1_mem;

     int status_code = 0;
    // Test error handling of passing null ptr
    // RingBuf_allocate() should return a -1 indicating function failed
    rbuf = RingBuf_allocate( buf_ptr, buf_sz);
    if(!rbuf)
    {
        printf("\t--RingBuf_allocate() failed valid call\r\n");
        return false;
    }

    for(int i = 0; i < sizeof(t_str)/sizeof(char); i++)
    {
        const uint8_t *temp_ptr = (const uint8_t *)&t_int[i];
        if(RingBuf_push(rbuf, temp_ptr, sizeof(char)) < 0)
        {
            printf("\t--Push failed\r\n");
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
    int status_code = 0;
    // Test error handling of passing null ptr
    // RingBuf_allocate() should return a -1 indicating function failed
    rbuf = RingBuf_allocate( buf_ptr, buf_sz);
    if(!rbuf)
    {
        printf("\t--RingBuf_allocate() failed valid call\r\n");
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
    
    int status_code = 0;
    // Test error handling of passing null ptr
    // RingBuf_allocate() should return a -1 indicating function failed
    rbuf = RingBuf_allocate( buf_ptr, buf_sz);
    if(!rbuf)
    {
        printf("\t--RingBuf_allocate() failed valid call\r\n");
        return false;
    }

    for(int i = 0; i < sizeof(t_int)/sizeof(int); i++)
    {
        const uint8_t *temp_ptr = (const uint8_t *)&t_int[i];
        if(RingBuf_push(rbuf, temp_ptr, sizeof(int)) < 0)
        {
            printf("\t--Push failed\r\n");
            return false;
        }   
    }

    return true;
}