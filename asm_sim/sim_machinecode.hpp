#pragma once

char add_machine[33] = {
    '0', '0', '0', '0', '0',
    '0', '0',
    '*', '*', '*', '*', '*',    // rs2
    '*', '*', '*', '*', '*',    // rs1
    '0', '0', '0',
    '*', '*', '*', '*', '*',    // rd
    '0', '1', '1', '0', '0',
    '1', '1',
};

char sub_machine[33] = {
    '0', '1', '0', '0', '0',
    '0', '0',
    '*', '*', '*', '*', '*',    // rs2
    '*', '*', '*', '*', '*',    // rs1
    '0', '0', '0',
    '*', '*', '*', '*', '*',    // rd
    '0', '1', '1', '0', '0',
    '1', '1',
};

char slt_machine[33] = {
    '0', '0', '0', '0', '0',
    '0', '0',
    '*', '*', '*', '*', '*',    // rs2
    '*', '*', '*', '*', '*',    // rs1
    '0', '1', '0',
    '*', '*', '*', '*', '*',    // rd
    '0', '1', '1', '0', '0',
    '1', '1',
};

char addi_machine[32] {
    '*', '*', '*', '*', '*',    // imm
    '*', '*',                   // imm
    '*', '*', '*', '*', '*',    // imm
    '*', '*', '*', '*', '*',    // rs1
    '0', '0', '0',
    '*', '*', '*', '*', '*',    // rd
    '0', '0', '1', '0', '0',
    '1', '1',
};

char lw_machine[32] {
    '*', '*', '*', '*', '*',    // offset
    '*', '*',                   // offset
    '*', '*', '*', '*', '*',    // offset
    '*', '*', '*', '*', '*',    // rs1
    '0', '1', '0',
    '*', '*', '*', '*', '*',    // rd
    '0', '0', '0', '0', '0',
    '1', '1',
};

char jalr_machine[32] {
    '*', '*', '*', '*', '*',    // offset
    '*', '*',                   // offset
    '*', '*', '*', '*', '*',    // offset
    '*', '*', '*', '*', '*',    // rs1
    '0', '0', '0',
    '*', '*', '*', '*', '*',    // rd
    '1', '1', '0', '0', '1',
    '1', '1',
};

char sw_machine[32] {
    '*', '*', '*', '*', '*',    // offset
    '*', '*',                   // offset
    '*', '*', '*', '*', '*',    // rs2
    '*', '*', '*', '*', '*',    // rs1
    '0', '1', '0',
    '*', '*', '*', '*', '*',    // offset
    '0', '1', '0', '0', '0',
    '1', '1',
};

char beq_machine[32] {
    '*', '*', '*', '*', '*',    // offset
    '*', '*',                   // offset
    '*', '*', '*', '*', '*',    // rs2
    '*', '*', '*', '*', '*',    // rs1
    '0', '0', '0',
    '*', '*', '*', '*', '*',    // offset
    '1', '1', '0', '0', '0',
    '1', '1',
};

char blt_machine[32] {
    '*', '*', '*', '*', '*',    // offset
    '*', '*',                   // offset
    '*', '*', '*', '*', '*',    // rs2
    '*', '*', '*', '*', '*',    // rs1
    '1', '0', '0',
    '*', '*', '*', '*', '*',    // offset
    '1', '1', '0', '0', '0',
    '1', '1',
};

char bge_machine[32] {
    '*', '*', '*', '*', '*',    // offset
    '*', '*',                   // offset
    '*', '*', '*', '*', '*',    // rs2
    '*', '*', '*', '*', '*',    // rs1
    '1', '0', '1',
    '*', '*', '*', '*', '*',    // offset
    '1', '1', '0', '0', '0',
    '1', '1',
};

char jal_machine[32] {
    '*', '*', '*', '*', '*',    // offset
    '*', '*',                   // offset
    '*', '*', '*', '*', '*',    // offset
    '*', '*', '*', '*', '*',    // offset
    '*', '*', '*',              // offset
    '*', '*', '*', '*', '*',    // rd
    '1', '1', '0', '1', '1',
    '1', '1',
};

char lui_machine[32] {
    '*', '*', '*', '*', '*',    // imm
    '*', '*',                   // imm
    '*', '*', '*', '*', '*',    // imm
    '*', '*', '*', '*', '*',    // imm
    '*', '*', '*',              // imm
    '*', '*', '*', '*', '*',    // rd
    '0', '1', '1', '0', '1',
    '1', '1',
};

char ori_machine[32] {
    '*', '*', '*', '*', '*',    // imm
    '*', '*',                   // imm
    '*', '*', '*', '*', '*',    // imm
    '*', '*', '*', '*', '*',    // rs1
    '1', '1', '0',
    '*', '*', '*', '*', '*',    // rd
    '0', '0', '1', '0', '0',
    '1', '1',
};

char mul_machine[32] = {
    '0', '0', '0', '0', '0',
    '0', '1',
    '*', '*', '*', '*', '*',    // rs2
    '*', '*', '*', '*', '*',    // rs1
    '0', '0', '0',
    '*', '*', '*', '*', '*',    // rd
    '0', '1', '1', '0', '0',
    '1', '1',
};

char div_machine[32] = {
    '0', '0', '0', '0', '0',
    '0', '1',
    '*', '*', '*', '*', '*',    // rs2
    '*', '*', '*', '*', '*',    // rs1
    '1', '0', '0',
    '*', '*', '*', '*', '*',    // rd
    '0', '1', '1', '0', '0',
    '1', '1',
};