#include <stdio.h>
#include <stdlib.h>
#include <time.h>

static unsigned int seed = 12345;

static float next_random(void)
{
    seed = seed * 1103515245u + 12345u;
    return (float)((seed >> 8) & 0xFFFF) / 65536.0f;
}

void fill(float *a, int n)
{
    for (int i = 0; i < n; i++)
        a[i] = next_random();
}

void matmul(const float *a, const float *b, float *c, int n)
{
    for (int i = 0; i < n * n; i++)
        c[i] = 0.0f;
    for (int i = 0; i < n; i++)
        for (int k = 0; k < n; k++) {
            float aik = a[i * n + k];
            for (int j = 0; j < n; j++)
                c[i * n + j] += aik * b[k * n + j];
        }
}

void axpy(float s, const float *x, float *y, int n)
{
    for (int i = 0; i < n; i++)
        y[i] = s * x[i] + y[i];
}

float dot(const float *a, const float *b, int n)
{
    float s = 0.0f;
    for (int i = 0; i < n; i++)
        s += a[i] * b[i];
    return s;
}

static double now(void)
{
    struct timespec t;
    clock_gettime(CLOCK_MONOTONIC, &t);
    return t.tv_sec + t.tv_nsec * 1e-9;
}

int main(int argc, char **argv)
{
    int n = argc > 1 ? atoi(argv[1]) : 1024;
    int len = argc > 2 ? atoi(argv[2]) : 16777216;
    int reps = argc > 3 ? atoi(argv[3]) : 50;

    float *a = malloc(sizeof(float) * n * n);
    float *b = malloc(sizeof(float) * n * n);
    float *c = malloc(sizeof(float) * n * n);
    float *x = malloc(sizeof(float) * len);
    float *y = malloc(sizeof(float) * len);
    if (!a || !b || !c || !x || !y) {
        fprintf(stderr, "not enough memory\n");
        return 1;
    }

    double t0 = now();
    fill(a, n * n);
    fill(b, n * n);
    fill(x, len);
    fill(y, len);
    double t1 = now();

    matmul(a, b, c, n);
    double t2 = now();

    for (int r = 0; r < reps; r++)
        axpy(0.5f, x, y, len);
    double t3 = now();

    float d = 0.0f;
    for (int r = 0; r < 10; r++)
        d += dot(x, y, len);
    double t4 = now();

    printf("fill   %.3f s\n", t1 - t0);
    printf("matmul %.3f s  c[0]=%.4f c[last]=%.4f\n", t2 - t1, c[0], c[n * n - 1]);
    printf("axpy   %.3f s  y[0]=%.4f y[last]=%.4f\n", t3 - t2, y[0], y[len - 1]);
    printf("dot    %.3f s  dot=%.2f\n", t4 - t3, d);
    printf("total  %.3f s\n", t4 - t0);

    free(a); free(b); free(c); free(x); free(y);
    return 0;
}
