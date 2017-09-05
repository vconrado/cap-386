#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

void usage(int    argc,
           char **argv);

int  check_params(uint32_t x_size,
                  uint32_t x_chunk_size,
                  uint32_t y_size,
                  uint32_t y_chunk_size,
                  uint32_t z_size,
                  uint32_t z_chunk_size,
                  uint32_t data_size);

int main(int argc, char *argv[]) {
  uint32_t x_size, x_chunk_size;
  uint32_t y_size, y_chunk_size;
  uint32_t z_size, z_chunk_size;
  uint32_t x, y, z;
  uint32_t xc, yc, zc;
  uint32_t seek;
  uint32_t data_size;
  uint32_t file_size;
  FILE    *input_file;
  FILE    *output_file;
  char    *input_file_name;
  char    *output_file_name;
  char    *buf;

  if (argc != 10) {
    usage(argc, argv);
    return 1;
  }
  x_size           = atoi(argv[1]);
  x_chunk_size     = atoi(argv[2]);
  y_size           = atoi(argv[3]);
  y_chunk_size     = atoi(argv[4]);
  z_size           = atoi(argv[5]);
  z_chunk_size     = atoi(argv[6]);
  data_size        = atoi(argv[7]);
  input_file_name  = argv[8];
  output_file_name = argv[9];

  if (check_params(x_size,               x_chunk_size,               y_size,
                   y_chunk_size,               z_size,               z_chunk_size,
                   data_size)) {
    return 2;
  }

  // Abrindo arquivos
  input_file = fopen(input_file_name, "rb");

  if (input_file == NULL) {
    fprintf(stderr, "Nao foi possivel abrir o arquivo %s\n", input_file_name);
    return 3;
  }

  // Verificando tamanho do arquivos
  fseek(input_file, 0L, SEEK_END);
  file_size = ftell(input_file);
  fseek(input_file, 0L, SEEK_SET);

  if (file_size != (x_size * y_size * z_size * data_size)) {
    fprintf(stderr,
            "O tamanho do arquivo '%s' e' incompatível como os dados informados.\n",
            input_file_name);
    return 4;
  }

  output_file = fopen(output_file_name, "wb");

  if (output_file == NULL) {
    fprintf(stderr, "Nao foi possivel abrir o arquivo %s\n", output_file_name);
    return 5;
  }

  buf            = (char *)malloc(sizeof(char) * (data_size + 1));
  buf[data_size] = 0;

  for (x = 0; x < x_size; x += x_chunk_size) {
    for (y = 0; y < y_size; y += y_chunk_size) {
      for (z = 0; z < z_size; z += z_chunk_size) {
        for (xc = 0; xc < x_chunk_size; ++xc) {
          for (yc = 0; yc < y_chunk_size; ++yc) {
            for (zc = 0; zc < z_chunk_size; ++zc) {
              seek = (x + xc) + (y + yc) * x_size + (z + zc) *
                     x_size * y_size;
              fseek(input_file, seek * data_size, SEEK_SET);

              if (fread(buf, sizeof(char), data_size, input_file) != data_size) {
                fprintf(stderr, "Error while reading file %s. ", input_file_name);
                fclose(input_file);
                fclose(output_file);
                return 10;
              }

              // printf("%i %s \n", seek, buf);
              fwrite(buf, sizeof(char), data_size, output_file);

              // printf("%i ", seek);
            }
          }
        }
      }
    }
  }
  free(buf);
  fclose(input_file);
  fclose(output_file);
  return 0;
}

void usage(int argc, char **argv) {
  fprintf(
    stderr,
    "Usage: %s X-size X-chunk-size Y-size Y-chunk-size Z-size Z-chunk-size data-size input_file output_file\n",
    argv[0]);
}

int check_params(uint32_t x_size,
                 uint32_t x_chunk_size,
                 uint32_t y_size,
                 uint32_t y_chunk_size,
                 uint32_t z_size,
                 uint32_t z_chunk_size,
                 uint32_t data_size) {
  if ((x_chunk_size < 1) || (y_chunk_size < 1) || (z_chunk_size < 1)) {
    fprintf(stderr, "Chunk size must be > 1.\n");
    return 1;
  }

  if ((x_size < x_chunk_size) || (y_size < y_chunk_size) ||
      (z_size < z_chunk_size)) {
    fprintf(stderr, "Domain size must equal or greather than chunk size.\n");
    return 2;
  }

  if (data_size < 1) {
    fprintf(stderr, "Data size must be > 1.\n");
    return 3;
  }
  return 0;
}
