'use strict';
const { Model } = require('sequelize');
module.exports = (sequelize, DataTypes) => {
    class Announcement extends Model {
        static associate(models) {
            // define association here
            this.belongsTo(models.User, {
                foreignKey: 'user_id'
            });
        }
    };
    Announcement.init({
        kind: {
            type: DataTypes.STRING,
            allowNull: false
        },
        title: {
            type: DataTypes.STRING,
            allowNull: false
        },
        content: {
            type: DataTypes.TEXT,
            allowNull: false
        },
    }, {
        sequelize,
        modelName: 'Announcement',
        createdAt: 'written_date',
        updatedAt: false,
    });
    return Announcement;
};
