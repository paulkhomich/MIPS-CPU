# MIPS CPU

Конвейерный MIPS процессор

Поддерживаемые инструкции:

`add sub and or xor beq bne sll srl`

`addi andi ori xori lw sw`

`j jr jal`

`nop`

## Запуск

Для успешного запуска необходимы `Icarus Verilog` и `GTKWave`

1. Тестовая программа пишется в файл `./program.asm` и может содержать не более 32 инструкций
2. `make`
3. `gtkwave dump.vcd`

## Структура

В папке `./assembler` хранятся скрипты для ассемблирования `./program.asm` в память процессора

В папке `./memory` хранятся файлы памяти инструкций, данных и регистрового файла. По ним можно изучать содержимое соответствующей памяти после выполнения программы

В папке `./src` хранятся verilog-модули процессора

в папке `./test` хранится тестовый модуль для процессора


## Устройство конвейера

1. 5 стадий [>F->D->E->M->W-]
2. Bypass в E из M/W (RAW конфликты арифметических операций)
3. Bypass в D из M (RAW конфликты вычисления BEQ/BNE)
4. Предсказатель условного ветвления (Продолжение выбора инструкций за условием)
5. Отчистка D стадии от неверного предсказания (Одна команда), а также от взятых на исполнение команд
после J/JR/JAL (Одна команда)
6. Остановка конвейера (RAW конфликты арифметических операций)
7. Остановка конвейера (RAW конфликты вычисления BEQ/BNE)
8. Остановка конвейера (Конфликт записи (JAL и команды в стадии W) в регистровый файл)

## Схема конвейера

Устройство управления конфликтами реализовано отдельно (Принимает сигналы из конвейера)

![Scheme](/__pics__/pipeline.jpg?raw=true)
