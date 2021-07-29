'use strict';
module.exports = {
  up: async (queryInterface, Sequelize) => {
    await queryInterface.createTable('Recomments', {
      id: {
        allowNull: false,
        autoIncrement: true,
        primaryKey: true,
        type: Sequelize.INTEGER
      },
      comment_id: {
        type: Sequelize.SMALLINT
      },
      user_id: {
        type: Sequelize.SMALLINT
      },
      content: {
        type: Sequelize.TEXT
      },
      reports_count: {
        type: Sequelize.SMALLINT
      },
      written_date: {
        type: Sequelize.DATE
      },
      revised_date: {
        type: Sequelize.DATE
      },
      deleted_date: {
        type: Sequelize.DATE
      },
      adopted_status: {
        type: Sequelize.TINYINT
      },
      deleted_status: {
        type: Sequelize.TINYINT
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
    await queryInterface.dropTable('Recomments');
  }
};