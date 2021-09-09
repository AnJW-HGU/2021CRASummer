'use strict';
module.exports = {
  up: async (queryInterface, Sequelize) => {
    await queryInterface.createTable('Cla_tests', {
      id: {
        allowNull: false,
        autoIncrement: true,
        primaryKey: true,
        type: Sequelize.INTEGER
      },
      구분: {
        type: Sequelize.STRING
      },
      과목코드: {
        type: Sequelize.STRING
      },
      분반: {
        type: Sequelize.STRING
      },
      과목명: {
        type: Sequelize.STRING
      },
      학점: {
        type: Sequelize.STRING
      },
      개설정보: {
        type: Sequelize.STRING
      },
      시간: {
        type: Sequelize.STRING
      },
      강의실: {
        type: Sequelize.STRING
      },
      정원: {
        type: Sequelize.STRING
      },
      인원: {
        type: Sequelize.STRING
      },
      영어: {
        type: Sequelize.STRING
      },
      교양: {
        type: Sequelize.STRING
      },
      성적유형: {
        type: Sequelize.STRING
      },
      PF병행: {
        type: Sequelize.STRING
      },
      강의: {
        type: Sequelize.STRING
      },
      비고: {
        type: Sequelize.STRING
      },
      createdAt: {
        allowNull: false,
        type: Sequelize.DATE
      },
      updatedAt: {
        allowNull: false,
        type: Sequelize.DATE
      }
    });
  },
  down: async (queryInterface, Sequelize) => {
    await queryInterface.dropTable('Cla_tests');
  }
};