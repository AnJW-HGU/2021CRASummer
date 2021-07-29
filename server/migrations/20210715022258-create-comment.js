'use strict';
module.exports = {
  up: async (queryInterface, Sequelize) => {
    await queryInterface.createTable('Comments', {
        id: {
            primaryKey: true,
            autoIncrement: true,
            type: Sequelize.SMALLINT,
            allowNull: false
        },
        post_id: {
            type: Sequelize.SMALLINT,
            allowNull: false,
        },
        user_id: {
            type: Sequelize.SMALLINT,
            allowNull: false,
        },
        content: {
            type: Sequelize.TEXT,
            allowNull: false,
        },
        recommends_count: {
            type: Sequelize.SMALLINT,
            defaultValue: 0,
            allowNull: false,
        },
        reports_count: {
            type: Sequelize.SMALLINT,
            defaultValue: 0,
            allowNull: false,
        },
        written_date: {
            type: Sequelize.DATE,
            allowNull: false,
        },
        revised_date: {
            type: Sequelize.DATE,
            allowNull: false,
        },
        deleted_date: {
            type: Sequelize.DATE,
            allowNull: false,
        },
        adopted_status: {
            type: Sequelize.TINYINT(1),
            allowNull: false,
        },
        deleted_status: {
            type: Sequelize.TINYINT(1),
            allowNull: false,
        }
    });
  },
  down: async (queryInterface, Sequelize) => {
    await queryInterface.dropTable('Comments');
  }
};
      
