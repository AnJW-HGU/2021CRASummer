'use strict';
module.exports = {
  up: async (queryInterface, Sequelize) => {
    await queryInterface.createTable('Classifications', {
        id: {
            primaryKey: true,
            autoIncrement: true,
            type: Sequelize.SMALLINT,
            allowNull: false
        },
        domain: {
            type: Sequelize.STRING(5),
            allowNull: false,
        },
        major: {
            type: Sequelize.STRING(15),
            allowNull: false,
        },
        subject: {
            type: Sequelize.STRING(100),
            allowNull: false,
        },
        professor_name: {
            type: Sequelize.STRING(65),
            allowNull: false,
        }
    });
  },
  down: async (queryInterface, Sequelize) => {
    await queryInterface.dropTable('Classifications');
  }
};
