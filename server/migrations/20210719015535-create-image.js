'use strict';
module.exports = {
  up: async (queryInterface, Sequelize) => {
    await queryInterface.createTable('Images', {
        id: {
            primaryKey: true,
            autoIncrement: true,
            type: Sequelize.SMALLINT,
            allowNull: false
        },
        post_id: {
            type: Sequelize.SMALLINT,
            defaultValue: null,
            allowNull: true,
        },
        comment_id: {
            type: Sequelize.SMALLINT,
            defaultValue: null,
            allowNull: true,
        },
        inquiry_id: {
            type: Sequelize.SMALLINT,
            defaultValue: null,
            allowNull: true,
        },
        user_id: {
            type: Sequelize.SMALLINT,
            allowNull: false,
        },
        original_file_name: {
            type: Sequelize.STRING(255),
            allowNull: false,
        },
        saved_file_name: {
            type: Sequelize.STRING(255),
            allowNull: false,
        },
        size: {
            type: Sequelize.BLOB,
            allowNull: false,
        },
        saved_path: {
            type: Sequelize.STRING(255),
            allowNull: false,
        },
        saved_date: {
            type: Sequelize.DATE,
            allowNull: false,
        },
        revised_date: {
            type: Sequelize.DATE,
            allowNull: false,
        },
        deleted_date: {
            type: Sequelize.DATE,
            allowNull: false
        },
        deleted_status: {
            type: Sequelize.TINYINT(1),
            allowNull: false
        },
    });
  },
  down: async (queryInterface, Sequelize) => {
    await queryInterface.dropTable('Images');
  }
};
